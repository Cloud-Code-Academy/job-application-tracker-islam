/**
 * Utility class to assist with application roles.
 */
public with sharing class ApplicationRoleHelper {

    /**
     * Sets the primary contact on the jobs for the given application role.
     * @param applicationRoleIds The IDs of The Application Roles that triggered this.
     */
    public void setPrimaryContact(Set<Id> applicationRoleIds) {
        // Fetch application roles with related job information
        List<Application_Role__c> applicationRoles = [  SELECT  Id,
                                                                Primary__c,
                                                                Contact__c,
                                                                Job_Application__r.Job__r.Primary_Contact__c
                                                        FROM    Application_Role__c
                                                        WHERE   Id IN :applicationRoleIds];

        // List to hold updated job records
        List<Job__c> jobs = new List<Job__c>();

        // Iterate through fetched application roles
        for (Application_Role__c currentApplicationRole: applicationRoles) {

            // Check if the application role is marked as primary and if the contact is different from the job's primary contact
            if (    currentApplicationRole.Primary__c == true &&
                    currentApplicationRole.Contact__c != currentApplicationRole.Job_Application__r.Job__r.Primary_Contact__c) {

                // Create a new job record with updated primary contact
                Job__c job = new Job__c(
                        Id = currentApplicationRole.Job_Application__r.Job__c,
                        Primary_Contact__c = currentApplicationRole.Contact__c
                );
                // Add the updated job record to the list
                jobs.add(job);
            }
        }
        // Update job records with new primary contact information
        update jobs;
    }

}
