/**
 * Created by islam on 4/12/2024.
 */

public with sharing class JobTriggerHandler extends TriggerHandler{


    private List<Job__c>       newJobList  ;
    private List<Job__c>       oldJobList  ;
    private Map<Id, Job__c>    newJobMap   ;
    private Map<Id, Job__c>    oldJobMap   ;
    JobTriggerHelper jobTriggerHelper = new JobTriggerHelper();

    public JobTriggerHandler(){
        this.newJobList = (List<Job__c>)   Trigger.new;
        this.oldJobList = (List<Job__c>)   Trigger.old;
        this.newJobMap  = (Map<Id, Job__c>)Trigger.newMap;
        this.oldJobMap  = (Map<Id, Job__c>)Trigger.oldMap;
    }

    public override void beforeInsert() {
        jobTriggerHelper.populatePrimaryContact(newJobList);

    }
}