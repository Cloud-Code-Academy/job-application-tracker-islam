/**
 * Trigger handler class for Application Role object.
 * Handles trigger events related to Application Role records.
 */
public with sharing class ApplicationRoleTriggerHandler extends TriggerHandler {

    // Lists to hold new and old Application Role records
    private List<Application_Role__c> newApplicationRoleList;
    private List<Application_Role__c> oldApplicationRoleList;

    // Maps to hold new and old Application Role records by their IDs
    private Map<Id, Application_Role__c> newApplicationRoleMap;
    private Map<Id, Application_Role__c> oldApplicationRoleMap;

    // Instance of ApplicationRoleHelper class for helper methods
    ApplicationRoleHelper applicationRoleHelper = new ApplicationRoleHelper();

    /**
     * Constructor to initialize trigger context variables.
     */
    public ApplicationRoleTriggerHandler() {
        this.newApplicationRoleList = (List<Application_Role__c>) Trigger.new;
        this.oldApplicationRoleList = (List<Application_Role__c>) Trigger.old;
        this.newApplicationRoleMap = (Map<Id, Application_Role__c>) Trigger.newMap;
        this.oldApplicationRoleMap = (Map<Id, Application_Role__c>) Trigger.oldMap;
    }

    /**
     * Overrides the afterInsert method from the TriggerHandler base class.
     * Invokes a helper method to set primary contact on Jobs.
     */
    public override void afterInsert() {
        applicationRoleHelper.setPrimaryContact(newApplicationRoleMap.keySet());
    }

}
