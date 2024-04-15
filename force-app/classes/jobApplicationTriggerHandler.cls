/**
 * Created by islam on 4/12/2024.
 */

/**
 * This trigger handler class manages the assignment of tasks based on changes in the status of job applications.
 */
public with sharing class jobApplicationTriggerHandler extends TriggerHandler{

    private List<Job_Application__c>       newJobApplicationList  ; // List of new job applications
    private List<Job_Application__c>       oldJobApplicationList  ; // List of old job applications
    private Map<Id, Job_Application__c>    newJobApplicationMap   ; // Map of new job applications by Id
    private Map<Id, Job_Application__c>    oldJobApplicationMap   ; // Map of old job applications by Id

    // Constructor initializing lists and maps with trigger context variables.
    public jobApplicationTriggerHandler(){
        this.newJobApplicationList = (List<Job_Application__c>)   Trigger.new;
        this.oldJobApplicationList = (List<Job_Application__c>)   Trigger.old;
        this.newJobApplicationMap  = (Map<Id, Job_Application__c>)Trigger.newMap;
        this.oldJobApplicationMap  = (Map<Id, Job_Application__c>)Trigger.oldMap;
    }

    /**
    * Method invoked after new job applications are inserted.
    * Assigns tasks based on the status of the job applications.
    */
    public override void afterInsert() {
        List<Task> tasks = new List<Task>();
        for (Job_Application__c currentJobApplication: newJobApplicationList) {

            // Check if status is not blank
            if (String.isNotBlank(currentJobApplication.Status__c)) {
                tasks.addAll(jobApplicationTriggerHelper.assignTasksBasedOnStatus(currentJobApplication.Status__c, currentJobApplication.Id));
            }


        }
        insert tasks; // Insert assigned tasks

    }



    /**
     * Method invoked before job applications are updated.
     * Assigns tasks based on the status changes of the job applications.
     */
    public override void beforeUpdate() {
        List<Task> tasks = new List<Task>();
        for (Job_Application__c currentJobApplication: newJobApplicationList) {

            // Check if status is not blank and has changed
            if (String.isNotBlank(currentJobApplication.Status__c) &&
                    currentJobApplication.Status__c != oldJobApplicationMap.get(currentJobApplication.Id).Status__c) {
                tasks.addAll(jobApplicationTriggerHelper.assignTasksBasedOnStatus(currentJobApplication.Status__c, currentJobApplication.Id));
            }

        }
        insert tasks; // Insert assigned tasks
    }








}