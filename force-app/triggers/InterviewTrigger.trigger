/**
 * Created by islam on 4/17/2024.
 */

trigger InterviewTrigger on Interview__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    System.debug('interview trigger worked');
    InterviewTriggerHandler interviewTriggerHandler = new InterviewTriggerHandler();
    interviewTriggerHandler.run();
}