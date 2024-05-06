/**
 * Created by islam on 4/12/2024.
 */

public with sharing class updatePrimaryContactOnJobs implements Schedulable {
    public void execute(SchedulableContext context) {
        List<Job__c> jobs = [   SELECT  Id, Company__c
                                FROM    Job__c
                                WHERE   Company__c          != NULL
                                AND     Primary_Contact__c   = NULL];
        Map<Id, Job__c> idToJobMap = new Map<Id, Job__c>();
        Set<Id> companyIds = new Set<Id>();
        for (Job__c currentJob: jobs) {
            idToJobMap.put(currentJob.Company__c, currentJob);
            companyIds.add(currentJob.Company__c);
        }

        List<Contact> contacts = [  SELECT  Id, AccountId
                                    FROM    Contact
                                    WHERE   AccountId IN :companyIds];

        if (contacts.size() > 0) {
            Map<Id, Contact> idToContactMap = new Map<Id, Contact>();
            List<Job__c> jobsToBeUpdated    = new List<Job__c>();
            for (Contact currentContact: contacts) {
                idToContactMap.put(currentContact.AccountId, currentContact);
            }
            for (Job__c currentJob: idToJobMap.values()) {
                if (idToContactMap.get(currentJob.Company__c) != null) {
                    currentJob.Primary_Contact__c = idToContactMap.get(currentJob.Company__c).Id;
                    jobsToBeUpdated.add(currentJob);
                }
            }
            update jobsToBeUpdated;
        }
    }

    public static void scheduleJob(String jobName) {
        String cronExp = '0 0 0 * * ?';
        System.schedule(jobName, cronExp, new updatePrimaryContactOnJobs());
    }
}