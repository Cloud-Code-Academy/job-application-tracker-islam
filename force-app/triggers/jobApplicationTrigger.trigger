/**
 * Created by islam on 4/12/2024.
 */

trigger jobApplicationTrigger on Job_Application__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    jobApplicationTriggerHandler jobApplicationTriggerHandler = new jobApplicationTriggerHandler();
    jobApplicationTriggerHandler.run();
}