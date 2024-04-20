/**
 * Created by islam on 4/20/2024.
 */

@IsTest
private class jobApplicationTriggerHandlerTest {
    @IsTest
    static void testJobApplicationTriggerHandler_assignTasksBasedOnStatus() {

        Job_Application__c jobApplicationSaved        = new Job_Application__c(Status__c = 'Saved');
        Job_Application__c jobApplicationApplying     = new Job_Application__c(Status__c = 'Applying');
        Job_Application__c jobApplicationApplied      = new Job_Application__c(Status__c = 'Applied');
        Job_Application__c jobApplicationInterviewing = new Job_Application__c(Status__c = 'Interviewing');
        Job_Application__c jobApplicationNegotiating  = new Job_Application__c(Status__c = 'Negotiating');
        Job_Application__c jobApplicationAccepted     = new Job_Application__c(Status__c = 'Accepted');
        Job_Application__c jobApplicationClosed       = new Job_Application__c(Status__c = 'Closed');

        List<Job_Application__c> jobApplications = new List<Job_Application__c>();
        jobApplications.add(jobApplicationSaved);
        jobApplications.add(jobApplicationApplying);
        jobApplications.add(jobApplicationApplied);
        jobApplications.add(jobApplicationInterviewing);
        jobApplications.add(jobApplicationNegotiating);
        jobApplications.add(jobApplicationAccepted);
        jobApplications.add(jobApplicationClosed);



        Test.startTest();
        insert jobApplications;
        Test.stopTest();

        List<Job_Application__c> jobApplicationsWithTasks = [SELECT Id, Status__c, (SELECT Id, Subject FROM Tasks) FROM Job_Application__c];

        for (Job_Application__c currentJobApplication: jobApplicationsWithTasks) {

            if (currentJobApplication.Status__c == 'Accepted') {
                System.assertEquals(3, currentJobApplication.Tasks.size());
            }
            if (currentJobApplication.Status__c == 'Applying') {
                System.assertEquals(5, currentJobApplication.Tasks.size());
            }
            if (currentJobApplication.Status__c == 'Applied') {
                System.assertEquals(4, currentJobApplication.Tasks.size());
            }
            if (currentJobApplication.Status__c == 'Interviewing') {
                System.assertEquals(5, currentJobApplication.Tasks.size());
            }
            if (currentJobApplication.Status__c == 'Negotiating') {
                System.assertEquals(3, currentJobApplication.Tasks.size());
            }
            if (currentJobApplication.Status__c == 'Accepted') {
                System.assertEquals(3, currentJobApplication.Tasks.size());
            }
            if (currentJobApplication.Status__c == 'Closed') {
                System.assertEquals(2, currentJobApplication.Tasks.size());
            }

        }


    }
}