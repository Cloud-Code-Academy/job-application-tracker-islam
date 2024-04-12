/**
 * Created by islam on 4/12/2024.
 */

public with sharing class cleanUpStaleJobsApplications implements Schedulable {
    public void execute(SchedulableContext context) {
        System.debug('started');
        Date thirtyDaysAgo = Date.today()-30;
        System.debug('date is ::: '  + thirtyDaysAgo);
        List<Job_Application__c> staleJobApplications =
        [   SELECT  Id
            FROM    Job_Application__c
            WHERE   Follow_Up_Date__c != null           AND
                    Follow_Up_Date__c <= :thirtyDaysAgo AND
                    Status__c != 'Closed'               AND
                    Status__c != 'Accepted' ];
        System.debug('found these applications ::: ' + staleJobApplications);

        List<Job_Application__c> jobApplicationsToBeUpdated = new List<Job_Application__c>();
        for (Job_Application__c currentJobApplication: staleJobApplications) {
            currentJobApplication.Status__c = 'Closed';
            currentJobApplication.Notes__c = 'Job application was closed by an automated process due to being stale for 30 days';
            jobApplicationsToBeUpdated.add(currentJobApplication);
        }
        update jobApplicationsToBeUpdated;
    }

    public static void scheduleJob() {
        String cronExp = '0 0 0 * * ?';
        System.schedule('cleanUpStaleJobsApplications', cronExp, new cleanUpStaleJobsApplications());
    }
}