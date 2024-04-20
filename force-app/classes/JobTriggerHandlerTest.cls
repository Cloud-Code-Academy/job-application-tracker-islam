/**
 * Created by islam on 4/18/2024.
 */

@IsTest
private class JobTriggerHandlerTest {
    @IsTest(SeeAllData=false)
    static void testJobTriggerHandler_populatePrimaryContact() {

        // Account with Contact
        Account accountWithContact = new Account(Name='accountWithContact');
        insert accountWithContact;
        Contact contact = new Contact(AccountId= accountWithContact.Id, LastName='Doe');
        insert contact;

        // Account without contact
        Account accountWithoutContact = new Account(Name='accountWithoutContact');
        insert accountWithoutContact;

        List<Job__c> jobs = new List<Job__c>();

        Job__c jobWithContact = new Job__c(Company__c = accountWithContact.Id);
        Job__c jobWithoutContact = new Job__c();

        jobs.add(jobWithoutContact);
        jobs.add(jobWithContact);

        Test.startTest();
        insert jobs;
        Test.stopTest();

        List<Job__c> updatedJobs = [SELECT Id, Primary_Contact__c, Company__c FROM Job__c];
        for (Job__c currentJob: updatedJobs) {
            if (currentJob.Company__c != null) {
                System.assertEquals(contact.Id, currentJob.Primary_Contact__c);
            } else {
                system.assert(currentJob.Primary_Contact__c == null);
            }
        }

    }
}