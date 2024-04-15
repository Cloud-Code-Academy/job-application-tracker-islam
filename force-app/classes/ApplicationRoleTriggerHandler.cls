/**
 * Created by islam on 4/13/2024.
 */

public with sharing class ApplicationRoleTriggerHandler extends TriggerHandler{


    private List<Application_Role__c>       newApplicationRoleList  ;
    private List<Application_Role__c>       oldApplicationRoleList  ;
    private Map<Id, Application_Role__c>    newApplicationRoleMap   ;
    private Map<Id, Application_Role__c>    oldApplicationRoleMap   ;

    public ApplicationRoleTriggerHandler(){
        this.newApplicationRoleList = (List<Application_Role__c>)   Trigger.new;
        this.oldApplicationRoleList = (List<Application_Role__c>)   Trigger.old;
        this.newApplicationRoleMap  = (Map<Id, Application_Role__c>)Trigger.newMap;
        this.oldApplicationRoleMap  = (Map<Id, Application_Role__c>)Trigger.oldMap;
    }

    public override void afterInsert() {
        List<Application_Role__c> applicationRoles = [SELECT Id, Primary__c, Contact__c, Job_Application__r.Job__r.Primary_Contact__c FROM Application_Role__c WHERE Id IN :newApplicationRoleMap.keySet()];
        List<Job__c> jobs = new List<Job__c>();
        for (Application_Role__c currentApplicationRole: applicationRoles) {
            System.debug('current application role job is ::: ' + currentApplicationRole.Job_Application__r.Job__c);
                if (currentApplicationRole.Primary__c == true && currentApplicationRole.Contact__c != currentApplicationRole.Job_Application__r.Job__r.Primary_Contact__c) {
                    Job__c job = new Job__c(
                            Id = currentApplicationRole.Job_Application__r.Job__c,
                            Primary_Contact__c = currentApplicationRole.Contact__c
                    );
                    jobs.add(job);
                }
        }
        System.debug(jobs);
        update jobs;
    }

}