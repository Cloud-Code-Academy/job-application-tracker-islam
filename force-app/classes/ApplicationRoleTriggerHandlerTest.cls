/**
 * Created by islam on 4/18/2024.
 */

@IsTest
private class ApplicationRoleTriggerHandlerTest {
    @IsTest
    static void testApplicationRoleTriggerHandler_setPrimaryContact() {

        Account account = new Account(Name='Chocolate Factory');
        insert account;

        Job__c job = new Job__c(Name='Salesforce Admin',
                                Company__c = account.Id,
                                Position_Title__c = 'Salesforce Admin');
        insert job;

        Job_Application__c jobApplication = new Job_Application__c(Job__c = job.Id);
        insert jobApplication;

        Contact contact = new Contact(LastName='Doe');
        insert contact;

        Application_Role__c applicationRole = new Application_Role__c(  Job_Application__c = jobApplication.Id,
                                                                        Contact__c = contact.Id,
                                                                        Primary__c = true);
        Test.startTest();
        insert applicationRole;
        Test.stopTest();

        Job__c updatedJob = [SELECT Id, Primary_Contact__c FROM Job__c WHERE Id = :job.Id];
        System.assertEquals(contact.Id, updatedJob.Primary_Contact__c);

    }
}