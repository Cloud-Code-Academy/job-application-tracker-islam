/**
 * Created by islam on 4/13/2024.
 */

trigger ApplicationRoleTrigger on Application_Role__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    ApplicationRoleTriggerHandler applicationRoleTriggerHandler = new ApplicationRoleTriggerHandler();
    applicationRoleTriggerHandler.run();

}