/**
 * Created by islam on 4/18/2024.
 */

public with sharing class ApplicationRoleHelper {

    public void setPrimaryContact(Set<Id> applicationRoleIds) {
        List<Application_Role__c> applicationRoles = [SELECT Id, Primary__c, Contact__c, Job_Application__r.Job__r.Primary_Contact__c FROM Application_Role__c WHERE Id IN :applicationRoleIds];
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
        update jobs;
    }

}