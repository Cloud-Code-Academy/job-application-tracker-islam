/**
 * Created by islam on 4/12/2024.
 */

trigger jobTrigger on Job__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    JobTriggerHandler jobTriggerHandler = new jobTriggerHandler();
    jobTriggerHandler.run();
}