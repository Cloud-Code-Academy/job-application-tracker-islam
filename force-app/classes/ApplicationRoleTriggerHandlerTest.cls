/**
 * Test class for ApplicationRoleTriggerHandler.
 */
@IsTest
private class ApplicationRoleTriggerHandlerTest {

    /**
     * Test method to verify the functionality of setting primary contact on Jobs.
     */
    @IsTest
    static void testApplicationRoleTriggerHandler_setPrimaryContact() {
        // Create test Company
        Account account = new Account(Name='Chocolate Factory');
        insert account;

        // Create test Job
        Job__c job = new Job__c( Name              ='Salesforce Admin',
                                 Company__c        = account.Id,
                                 Position_Title__c = 'Salesforce Admin');
        insert job;

        // Create test Job Application
        Job_Application__c jobApplication = new Job_Application__c(Job__c = job.Id);
        insert jobApplication;

        // Create test Contact
        Contact contact = new Contact(LastName='Doe');
        insert contact;

        // Create test Application Role with primary checkbox equals true
        Application_Role__c applicationRole = new Application_Role__c(  Job_Application__c  = jobApplication.Id,
                                                                        Contact__c          = contact.Id,
                                                                        Primary__c          = true);
        // Start test context
        Test.startTest();
        insert applicationRole;
        Test.stopTest();

        // Verify that the primary contact is set in the related Job record
        Job__c updatedJob = [   SELECT Id, Primary_Contact__c
                                FROM Job__c
                                WHERE Id = :job.Id];
        System.assertEquals(contact.Id, updatedJob.Primary_Contact__c);
    }
}
