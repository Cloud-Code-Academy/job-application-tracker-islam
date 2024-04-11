/**
 * Created by islam on 4/8/2024.
 */

public with sharing class findJobsHelper {

    @AuraEnabled
    public static List<Job__c> insertJobs(List<Job__c> jobs) {

        /*
        writing the logic in plain English first
        Check if a company exists
        Collect Company Names
        Query these companies
        Jobs                = Map <Company Name, Job>
        existingAccounts    = Map <Company Name, Account>

        Loop Jobs
        check if existingAccounts keyset includes current company , if not > add to collection to get created

        create Accounts
        loop created accounts and add them to existingAccounts Map

        Loop jobs map and update every job with account id from existing accounts map
        */

        Set<String>          companyNames                   = collectCompanyNames(jobs);
        List<Account>        companies                      = queryCompanies(companyNames);
        Map<String, Job__c>  companyNameToJobMap            = setupCompanyNameToJobMap(jobs);
        Map<String, Account> companyNameToAccountMap        = setupCompanyNameToAccountMap(companies);
        List<Account>        newAccounts                    = createNewAccounts(companyNameToJobMap, companyNameToAccountMap);
        Map<String, Account> updatedCompanyNameToAccountMap = setupUpdatedCompanyNameToJobMap(newAccounts, companyNameToAccountMap);
        List<Job__c>         jobsWithAccountIDs             = assignAccountIDsToJobs(companyNameToJobMap, updatedCompanyNameToAccountMap);

        upsert jobsWithAccountIDs Jooble_ID__c;
        return jobsWithAccountIDs;
    }

    @AuraEnabled
    public static void insertJobApplications(List<Job__c> jobs) {
        List<Job__c> updatedJobs = insertJobs(jobs);
        List<Job_Application__c> jobApplications = new List<Job_Application__c>();

        for (Job__c currentJob: updatedJobs) {
            Job_Application__c newApplication = new Job_Application__c(
                    Job__c = currentJob.Id,
                    Applicant__c = UserInfo.getUserId(),
                    Status__c = 'Saved',
                    Application_Date__c = Date.today(),
                    Follow_Up_Date__c = Date.today().addDays(7)
            );
            jobApplications.add(newApplication);
        }
        insert jobApplications;
    }


    private static Set<String> collectCompanyNames(List<Job__c> jobs) {
        Set<String> companyNames = new Set<String>();
        for (Job__c currentJob: jobs) {
            companyNames.add(currentJob.Company_Name__c);
        }
        return companyNames;
    }
    private static List<Account> queryCompanies(Set<String> companies) {
        List<Account> accounts = [  SELECT  Id, Name
                                    FROM    Account
                                    WHERE   Name IN :companies];
        return accounts;
    }

    private static Map<String, Job__c> setupCompanyNameToJobMap(List<Job__c> jobs) {
        Map<String, Job__c> companyNameToJobMap = new Map<String, Job__c>();
        for (Job__c currentJob: jobs) {
            companyNameToJobMap.put(currentJob.Company_Name__c, currentJob);
        }
        return companyNameToJobMap;
    }
    private static Map<String, Account> setupCompanyNameToAccountMap(List<Account> companies) {
        Map<String, Account> companyNameToAccountMap = new Map<String, Account>();
        for (Account currentAccount: companies) {
            companyNameToAccountMap.put(currentAccount.Name, currentAccount);
        }
        return companyNameToAccountMap;
    }

    private static List<Account> createNewAccounts(Map<String, Job__c> companyNameToJobMap, Map<String, Account> companyNameToAccountMap) {
        List<Account> accountsToBeCreated = new List<Account>();
        for (String currentCompanyName: companyNameToJobMap.keySet()) {
            if (!companyNameToAccountMap.keySet().contains(currentCompanyName)) {
                Account newAccount = new Account(
                        Name = currentCompanyName
                );
                accountsToBeCreated.add(newAccount);
            }
        }
        insert accountsToBeCreated;
        return accountsToBeCreated;
    }

    private static Map<String, Account> setupUpdatedCompanyNameToJobMap(List<Account> newAccounts, Map<String, Account> companyNameToAccountMap) {
        for (Account currentAccount: newAccounts) {
            companyNameToAccountMap.put(currentAccount.Name, currentAccount);
        }
        return companyNameToAccountMap;
    }

    private static List<Job__c> assignAccountIDsToJobs(Map<String, Job__c>  companyNameToJobMap, Map<String, Account> updatedCompanyNameToAccountMap) {
        List<Job__c> jobs = new List<Job__c>();
        for (Job__c currentJob: companyNameToJobMap.values()) {
            currentJob.Company__c = updatedCompanyNameToAccountMap.get(currentJob.Company_Name__c).Id;
            jobs.add(currentJob);
        }
        return jobs;
    }
}