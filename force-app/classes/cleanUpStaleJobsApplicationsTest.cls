/**
 * Created by islam on 4/20/2024.
 */

@IsTest
private class cleanUpStaleJobsApplicationsTest {
    @IsTest
    static void testCleanUpStaleJobsApplications() {
        Date followUpDate = Date.today()-30;

        Job_Application__c jobApplicationSaved30        = new Job_Application__c(Follow_Up_Date__c = followUpDate, Status__c = 'Saved');
        Job_Application__c jobApplicationApplying30     = new Job_Application__c(Follow_Up_Date__c = followUpDate, Status__c = 'Applying');
        Job_Application__c jobApplicationApplied30      = new Job_Application__c(Follow_Up_Date__c = followUpDate, Status__c = 'Applied');
        Job_Application__c jobApplicationInterviewing30 = new Job_Application__c(Follow_Up_Date__c = followUpDate, Status__c = 'Interviewing');
        Job_Application__c jobApplicationNegotiating30  = new Job_Application__c(Follow_Up_Date__c = followUpDate, Status__c = 'Negotiating');

        followUpDate = followUpDate - 1;

        Job_Application__c jobApplicationSaved31        = new Job_Application__c(Follow_Up_Date__c = followUpDate, Status__c = 'Saved');
        Job_Application__c jobApplicationApplying31     = new Job_Application__c(Follow_Up_Date__c = followUpDate, Status__c = 'Applying');
        Job_Application__c jobApplicationApplied31      = new Job_Application__c(Follow_Up_Date__c = followUpDate, Status__c = 'Applied');
        Job_Application__c jobApplicationInterviewing31 = new Job_Application__c(Follow_Up_Date__c = followUpDate, Status__c = 'Interviewing');
        Job_Application__c jobApplicationNegotiating31  = new Job_Application__c(Follow_Up_Date__c = followUpDate, Status__c = 'Negotiating');

        List<Job_Application__c> jobApplications = new List<Job_Application__c>();
        jobApplications.add(jobApplicationSaved30);
        jobApplications.add(jobApplicationApplying30);
        jobApplications.add(jobApplicationApplied30);
        jobApplications.add(jobApplicationInterviewing30);
        jobApplications.add(jobApplicationNegotiating30);

        jobApplications.add(jobApplicationSaved31);
        jobApplications.add(jobApplicationApplying31);
        jobApplications.add(jobApplicationApplied31);
        jobApplications.add(jobApplicationInterviewing31);
        jobApplications.add(jobApplicationNegotiating31);

        insert jobApplications;

        Test.startTest();
        cleanUpStaleJobsApplications.scheduleJob();
        Test.stopTest();

        List<Job_Application__c> updatedJobApplications = [SELECT Id, Status__c, Notes__c FROM Job_Application__c];
        for (Job_Application__c currentJobApplication: updatedJobApplications) {
            System.assertEquals('Closed', currentJobApplication.Status__c);
            System.assertEquals('Job application was closed by an automated process due to being stale for 30 days', currentJobApplication.Notes__c);
        }
    }
}