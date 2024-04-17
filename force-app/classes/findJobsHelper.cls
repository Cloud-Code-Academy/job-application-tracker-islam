/**
 * Created by islam on 4/8/2024.
 */

public with sharing class findJobsHelper {

    @AuraEnabled
    public static List<Job__c> insertJobs(List<Job__c> jobs) {
        System.debug('jobs are ::: ');
        System.debug(jobs);

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
        // Existing Companies in the Database
        List<Account>        companies                      = queryCompanies(companyNames);
        // Existing Companies Names To Jobs (Doesn't include all jobs)
        Map<String, Job__c>  companyNameToJobMap            = setupCompanyNameToJobMap(jobs);
        // Existing Companies Account Names to Account records
        Map<String, Account> companyNameToAccountMap        = setupCompanyNameToAccountMap(companies);
        // of the jobs that have companies, create the companies that doesn't exist in the database
        List<Account>        newAccounts                    = createNewAccounts(companyNameToJobMap, companyNameToAccountMap);
        // After creating the accounts that didn't exist, create a new map that includes all companies (doesn't include all jobs)
        Map<String, Account> updatedCompanyNameToAccountMap = setupUpdatedCompanyNameToAccountMap(newAccounts, companyNameToAccountMap);
        // Assigns the Account IDs to the Jobs that had a company
        List<Job__c>         jobsWithAccountIDs             = assignAccountIDsToJobs(companyNameToJobMap, updatedCompanyNameToAccountMap);
        // Add the jobs that didn't have a company
        List<Job__c>         allJobs                        = collectJobsWithoutCompanies(jobsWithAccountIDs, jobs);

        upsert allJobs Jooble_ID__c;
        return allJobs;
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
            if (currentJob.Company_Name__c != null) {
                companyNames.add(currentJob.Company_Name__c);
            }

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
            if (currentJob.Company_Name__c != null) {
                companyNameToJobMap.put(currentJob.Company_Name__c, currentJob);
            }

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
        System.debug( 'companyNameToJobMap ::: ' +  companyNameToJobMap);
        System.debug( 'companyNameToAccountMap ::: ' + companyNameToAccountMap);

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

    private static Map<String, Account> setupUpdatedCompanyNameToAccountMap(List<Account> newAccounts, Map<String, Account> companyNameToAccountMap) {
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

    private static List<Job__c> collectJobsWithoutCompanies(List<Job__c> jobsWithAccountIDs, List<Job__c> jobs) {
        List<Job__c> allJobs = new List<Job__c>();
        allJobs.addAll(jobsWithAccountIDs);
        for (Job__c currentJob: jobs) {
            System.debug('current job company is ::: ' + currentJob.Company_Name__c);
            if (currentJob.Company_Name__c == null) {
                allJobs.add(currentJob);
            }
        }
        System.debug('all jobs are ::: ' + allJobs);
        return allJobs;
    }
}