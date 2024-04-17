/**
 * Created by islam on 4/12/2024.
 */

public with sharing class JobTriggerHandler extends TriggerHandler{


    private List<Job__c>       newJobList  ;
    private List<Job__c>       oldJobList  ;
    private Map<Id, Job__c>    newJobMap   ;
    private Map<Id, Job__c>    oldJobMap   ;

    public JobTriggerHandler(){
        this.newJobList = (List<Job__c>)   Trigger.new;
        this.oldJobList = (List<Job__c>)   Trigger.old;
        this.newJobMap  = (Map<Id, Job__c>)Trigger.newMap;
        this.oldJobMap  = (Map<Id, Job__c>)Trigger.oldMap;
    }

    public override void beforeInsert() {
        for (Job__c currentJob: newJobList) {
            if (currentJob.Company__c != null) {
                System.debug('current Job Company ID is ' +  currentJob.Company__c);
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