/**
 * Created by islam on 4/19/2024.
 */

@IsTest
private class updatePrimaryContactOnJobsTest {
    @IsTest
    static void testUpdatePrimaryContactOnJobs() {

        Account accountWithRelatedContact       = new Account(Name='accountWithRelatedContact');
        Account accountWithoutRelatedContact    = new Account(Name='accountWithoutRelatedContact');

        List<Account> accounts = new List<Account>();
        accounts.add(accountWithoutRelatedContact);
        accounts.add(accountWithRelatedContact);
        insert accounts;


        Job__c jobWithAccountWithRelatedContact     = new Job__c(Company__c = accountWithRelatedContact.Id);
        Job__c jobWithAccountWithoutRelatedContact  = new Job__c(Company__c = accountWithoutRelatedContact.Id);
        Job__c jobWithoutAccount                    = new Job__c();
        List<Job__c> jobs                           = new List<Job__c>();
        jobs.add(jobWithoutAccount);
        jobs.add(jobWithAccountWithRelatedContact);
        jobs.add(jobWithAccountWithoutRelatedContact);
        insert jobs;

        /*
        This scenario is meant for the time when a job is created for an account that doesn't have a contact.
        At a later time, someone creates a contact
        Scheduled APEX takes care of this.
        The other scenario is when a job is created for an existing company that has contact, the Trigger takes care of that.
        */
        Contact contact = new Contact(LastName='Doe', AccountId= accountWithRelatedContact.Id);
        insert contact;

        Test.startTest();
        updatePrimaryContactOnJobs.scheduleJob('testJob1');
        Test.stopTest();

        List<Contact> contacts = [  SELECT Id, AccountId
                                    FROM Contact];
        Map<Id, Contact> idToContactMap = new Map<Id, Contact>();
        for (Contact currentContact: contacts) {
            idToContactMap.put(currentContact.AccountId, currentContact);
        }

        List<Job__c> updatedJobs = [SELECT Id, Company__c, Primary_Contact__c
                                    FROM Job__c];

        for (Job__c currentJob: updatedJobs) {
            if (currentJob.Company__c == null) {
                system.assert(currentJob.Primary_Contact__c == null);
            } else if (currentJob.Company__c != null && idToContactMap.keySet().contains(currentJob.Company__c)) {
                System.assertEquals(idToContactMap.get(currentJob.Company__c).Id, currentJob.Primary_Contact__c);
            } else {
                system.assert(currentJob.Primary_Contact__c == null);
            }
        }
    }
}