/**
 * Created by islam on 4/13/2024.
 */

public with sharing class sendReminderEmails implements Schedulable {

    // This method executes scheduled tasks related to interviews for the next day.
    public void execute(SchedulableContext context) {
        // Calculate the beginning and end of tomorrow.
        Datetime beginningOfTomorrow = Date.today().addDays(1);
        Datetime endOfTomorrow = Date.today().addDays(2);

        // Query interviews scheduled for tomorrow.
        List<Interview__c> interviews = [
                SELECT Id,
                        Name,
                        Start_Date_Time__c,
                        End_Date_Time__c,
                        Job_Application__r.Applicant__c,
                        Job_Application__r.Applicant__r.Email,
                        Job_Application__r.Applicant__r.FirstName,
                        Job_Application__r.Job__r.Location__c,
                        Job_Application__r.Job__r.Name
                FROM Interview__c
                WHERE Start_Date_Time__c >= :beginningOfTomorrow
                AND Start_Date_Time__c < :endOfTomorrow
        ];

        // Create a set to store applicant IDs and a map to store applicant IDs to their interviews.
        Set<Id> applicantIDs = new Set<Id>();
        Map<Id, List<Interview__c>> applicantIdToTheirInterviewsMap = new Map<Id, List<Interview__c>>();

        // Iterate through interviews to populate the applicant IDs set and map.
        for (Interview__c currentInterview : interviews) {
            applicantIDs.add(currentInterview.Job_Application__r.Applicant__c);
            if (!applicantIdToTheirInterviewsMap.containsKey(currentInterview.Job_Application__r.Applicant__c)) {
                List<Interview__c> newListOfInterviews = new List<Interview__c>();
                applicantIdToTheirInterviewsMap.put(currentInterview.Job_Application__r.Applicant__c, newListOfInterviews);
            }
            applicantIdToTheirInterviewsMap.get(currentInterview.Job_Application__r.Applicant__c).add(currentInterview);
        }

        // Iterate through applicant IDs and send emails containing their interviews.
        for (Id currentApplicantID : applicantIdToTheirInterviewsMap.keySet()) {
            if (applicantIdToTheirInterviewsMap.get(currentApplicantID).size() > 0) {
                sendEmail(applicantIdToTheirInterviewsMap.get(currentApplicantID));
            }
        }
    }




    // This method schedules the job to send reminder emails for interviews.
    public static void scheduleJob() {
        // Define the cron expression to trigger the job at midnight every day.
        String cronExp = '0 0 0 * * ?';

        // Schedule the job to send reminder emails.
        System.schedule('sendReminderEmails', cronExp, new sendReminderEmails());
    }

    // This method sends reminder emails to applicants regarding their interviews scheduled for tomorrow.
    private static void sendEmail(List<Interview__c> interviews) {
        // Get the base URL of the organization.
        String baseUrl = URL.getOrgDomainUrl().toExternalForm();

        // Prepare a list of recipient emails.
        List<String> emails = new List<String>();
        emails.add(interviews.get(0).Job_Application__r.Applicant__r.Email);

        // Create a single email message.
        Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
        emailMessage.setToAddresses(emails);
        emailMessage.setSubject('Tomorrow\'s Interviews');

        // Set the email body with HTML content.
        String htmlBody = '<html><body>';
        htmlBody += 'Hello ' + interviews.get(0).Job_Application__r.Applicant__r.FirstName + ',<br/><br/>';
        htmlBody += 'Here are the interviews scheduled for tomorrow:<br/><br/>';
        htmlBody += '<table border="1" style="border: 1px solid black; border-collapse: collapse;">';
        htmlBody += '<tr><th style="padding: 5px;">Job</th><th style="padding: 5px;">Date</th><th style="padding: 5px;">Location</th></tr>';

        // Populate the interview details in the email body.
        for (Interview__c currentInterview : interviews) {
            String interviewURL = baseUrl + '/' + currentInterview.Id;
            htmlBody += '<tr>';
            htmlBody += '<td style="padding: 5px;">' + '<a href="' + interviewURL + '">' + currentInterview.Job_Application__r.Job__r.Name + '</a>' + '</td>';
            htmlBody += '<td style="padding: 5px;">' + currentInterview.Start_Date_Time__c.format() + '</td>';
            htmlBody += '<td style="padding: 5px;">' + currentInterview.Job_Application__r.Job__r.Location__c + '</td>';
            htmlBody += '</tr>';
        }

        htmlBody += '</table><br/><br/>';
        htmlBody += 'Yours,<br/>APEX Buddy';
        htmlBody += '</body></html>';

        // Set the HTML body of the email message.
        emailMessage.setHtmlBody(htmlBody);

        // Send the email message.
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        emailMessages.add(emailMessage);
        System.debug('emailMessages ::: ' + emailMessages);
        List<Messaging.SendEmailResult>  sendEmailResults = Messaging.sendEmail(emailMessages);
    }

}