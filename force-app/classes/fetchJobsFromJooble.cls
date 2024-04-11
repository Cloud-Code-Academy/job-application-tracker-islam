/**
 * Created by islam on 4/9/2024.
 */

public with sharing class fetchJobsFromJooble {

    final static Integer numberOfHoursPerYear = 40 * 4 * 12;


    @AuraEnabled(Cacheable=true)
    public static List<Job__c> getJobs() {

        String apiKey = getJoobleApiKey();
        HttpRequest JoobleHttpRequest = setupHttpRequest(apiKey);
        Http JoobleHttp = new Http();
        HttpResponse JoobleHttpResponse = JoobleHttp.send(JoobleHttpRequest);
        List<Job__c> jobs = processResponse(JoobleHttpResponse);
        System.debug(jobs);
        return jobs;
    }


    // Helper Methods
    private static String getJoobleApiKey() {
        return [SELECT Id, API_Key__c FROM Jooble__c].API_Key__c;
    }

    private static HttpRequest setupHttpRequest(String apiKey) {
        // Set up the HTTP request
        HttpRequest JoobleHttpRequest = new HttpRequest();

        JoobleHttpRequest.setEndpoint('callout:NCJooble' + '/' + apiKey);
        JoobleHttpRequest.setMethod('POST'); // Use GET method to fetch data
        JoobleHttpRequest.setHeader('Content-Type', 'application/json');

        Map<String, Object> bodyMap = new Map<String, Object>();
        bodyMap.put('keywords', 'Salesforce');
        bodyMap.put('location', 'USA');
        bodyMap.put('salary', 1);
        String body = JSON.serialize(bodyMap);
        JoobleHttpRequest.setBody(body);

        return JoobleHttpRequest;
    }
    private static List<Job__c> processResponse(HttpResponse httpResponse) {
        // Process the response
        String responseBody = httpResponse.getBody();
        System.debug('Response status code: '   + httpResponse.getStatusCode());
        System.debug('Response status: '        + httpResponse.getStatus());

        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
        List<Object> responseJobs = (List<Object>) responseMap.get('jobs');
        List<Job__c> jobs = new List<Job__c>();

        for (Object currentJob: responseJobs) {
            Map<String, Object> currentJobMap = (Map<String, Object>) currentJob;
            String jobNameAndTitle = (String) currentJobMap.get('title');
            String salaryRange = (String) currentJobMap.get('salary');
            Decimal lowerBound = calculateSalaryLowerBound(salaryRange);
            Decimal upperBound = calculateSalaryUpperBound(salaryRange);
            String snippet = (String) currentJobMap.get('snippet');
            Job__c job = new Job__c(
                    Position_Title__c     = jobNameAndTitle,
                    Name                  = jobNameAndTitle,
                    Salary_Range__c       = salaryRange,
                    Salary_Lower_Bound__c = lowerBound,
                    Salary_Upper_Bound__c = upperBound,
                    Salary__c             = calculateAverageSalary(upperBound, lowerBound),
                    Description__c        = snippet.stripHtmlTags(),
                    URL__c                = (String) currentJobMap.get('link'),
                    Location__c           = (String) currentJobMap.get('location'),
                    Jooble_ID__c          = convertIdLongToID((Long) currentJobMap.get('id')),
                    Company_Name__c       = (String) currentJobMap.get('company')
            );
            jobs.add(job);
        }
        return jobs;
    }

    private static Decimal calculateSalaryLowerBound(String salaryRange) {

        Decimal salaryLowerBound = 0;

        // Hourly Rate - Fixed. Example "$20 per hour"
        if (salaryRange.containsIgnoreCase('per hour') && !salaryRange.containsIgnoreCase('-') && salaryRange.startsWithIgnoreCase('$') && salaryRange.endsWithIgnoreCase('per hour')) {
            Decimal hourlyRate = Decimal.valueOf(salaryRange.substring(1, salaryRange.indexOfIgnoreCase(' ')).trim());
            System.debug(' $20 per hour - hourly rate is ' + hourlyRate);
            salaryLowerBound = hourlyRate * numberOfHoursPerYear;
        }

        // Hourly Rate - Range. Example "$85 - $90 per hour"
        else if (salaryRange.containsIgnoreCase('per hour') && salaryRange.startsWithIgnoreCase('$') && salaryRange.containsIgnoreCase('-') && salaryRange.endsWithIgnoreCase('per hour')) {
            Decimal hourlyRate = Decimal.valueOf(salaryRange.substring(1, salaryRange.indexOfIgnoreCase('-')).trim());
            salaryLowerBound = hourlyRate * numberOfHoursPerYear; // Hourly Rate * Number of Hours per week * Number of Weeks Per Month * Number of Months per year
        }
        // Annual Range. Example "$75k - $85k"
        else if (salaryRange.containsIgnoreCase('k') && salaryRange.containsIgnoreCase('-') && salaryRange.startsWithIgnoreCase('$') && salaryRange.endsWithIgnoreCase('k')) {
            salaryLowerBound = Decimal.valueOf(salaryRange.substring(1, salaryRange.indexOfIgnoreCase('k')).trim());
            salaryLowerBound = salaryLowerBound * 1000;
        }
        else {
            salaryLowerBound = null;
        }
        return salaryLowerBound;
    }


    private static Decimal calculateSalaryUpperBound(String salaryRange) {

        Decimal salaryUpperBound = 0;
        String upperBoundString = salaryRange.substring(salaryRange.indexOfIgnoreCase('-')+1).trim();

        // Hourly Rate - Fixed. Example "$20 per hour"
        if (salaryRange.containsIgnoreCase('per hour') && !salaryRange.containsIgnoreCase('-')) {
            System.debug('Hourly Rate - Fixed');
            Decimal hourlyRate = Decimal.valueOf(upperBoundString.substring(1, upperBoundString.indexOfIgnoreCase(' ')).trim());
            System.debug(' $20 per hour - hourly rate is ' + hourlyRate);
            salaryUpperBound = hourlyRate * numberOfHoursPerYear;
        }

        // Hourly Rate
        else if (salaryRange.containsIgnoreCase('per hour')) {
            System.debug('Hourly Rate - Range');
            Decimal hourlyRate = Decimal.valueOf(upperBoundString.substring(1, upperBoundString.indexOfIgnoreCase(' ')).trim());
            salaryUpperBound = hourlyRate * numberOfHoursPerYear; // Hourly Rate * Number of Hours per week * Number of Weeks Per Month * Number of Months per year
        }
        // Annual Range
        else if (salaryRange.containsIgnoreCase('k')) {
            System.debug('annual range');
            System.debug('upperBoundString is ::: '  + upperBoundString);
            System.debug('salaryRange.indexOfIgnoreCase(\'$\') is ::: ' + salaryRange.indexOfIgnoreCase('$'));
            System.debug('salaryRange.indexOfIgnoreCase(\'k\') is ::: ' + salaryRange.indexOfIgnoreCase('k'));
            salaryUpperBound = Decimal.valueOf(upperBoundString.substring(1, upperBoundString.indexOfIgnoreCase('k')).trim());
            salaryUpperBound = salaryUpperBound * 1000;
        }
        else {
            salaryUpperBound = null;
        }
        return salaryUpperBound;
    }

    private static Decimal calculateAverageSalary(Decimal upperBound, Decimal lowerBound) {
        return ( (upperBound + lowerBound) / 2);
    }
    private static String convertIdLongToID(Long id) {
        return String.valueOf(id);
    }

}