/**
 * Created by islam on 4/18/2024.
 */

public with sharing class JobTriggerHelper {

    public void populatePrimaryContact(List<Job__c> newJobList) {

        for (Job__c currentJob: newJobList) {
            if (currentJob.Company__c != null) {
                List<Contact> contacts = [  SELECT  Id, FirstName, LastName
                                            FROM    Contact
                                            WHERE   AccountId = :currentJob.Company__c];

                if (contacts.size()> 0) {
                    currentJob.Primary_Contact__c = contacts.get(0).Id;
                }
            }
        }
    }
}