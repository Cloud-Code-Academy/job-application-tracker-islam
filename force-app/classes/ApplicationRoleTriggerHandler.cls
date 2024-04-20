/**
 * Created by islam on 4/13/2024.
 */

public with sharing class ApplicationRoleTriggerHandler extends TriggerHandler{


    private List<Application_Role__c>       newApplicationRoleList  ;
    private List<Application_Role__c>       oldApplicationRoleList  ;
    private Map<Id, Application_Role__c>    newApplicationRoleMap   ;
    private Map<Id, Application_Role__c>    oldApplicationRoleMap   ;
    ApplicationRoleHelper applicationRoleHelper = new ApplicationRoleHelper();

    public ApplicationRoleTriggerHandler(){
        this.newApplicationRoleList = (List<Application_Role__c>)   Trigger.new;
        this.oldApplicationRoleList = (List<Application_Role__c>)   Trigger.old;
        this.newApplicationRoleMap  = (Map<Id, Application_Role__c>)Trigger.newMap;
        this.oldApplicationRoleMap  = (Map<Id, Application_Role__c>)Trigger.oldMap;
    }

    public override void afterInsert() {
        applicationRoleHelper.setPrimaryContact(newApplicationRoleMap.keySet());
    }

}