/**
 * Created by islam on 4/17/2024.
 */

public with sharing class InterviewTriggerHandler extends TriggerHandler{



    private List<Interview__c>       newInterviewList  ;
    private List<Interview__c>       oldInterviewList  ;
    private Map<Id, Interview__c>    newInterviewMap   ;
    private Map<Id, Interview__c>    oldInterviewMap   ;
    InterviewHelper interviewHelper = new InterviewHelper();

    public InterviewTriggerHandler(){
        this.newInterviewList = (List<Interview__c>)   Trigger.new;
        this.oldInterviewList = (List<Interview__c>)   Trigger.old;
        this.newInterviewMap  = (Map<Id, Interview__c>)Trigger.newMap;
        this.oldInterviewMap  = (Map<Id, Interview__c>)Trigger.oldMap;
    }

    public override void beforeInsert() {

        interviewHelper.checkOverlaps(newInterviewList);

    }



}