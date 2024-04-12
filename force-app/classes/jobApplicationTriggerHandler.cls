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

    /**
     * Constructor initializing lists and maps with trigger context variables.
     */
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
                tasks.addAll(assignTasksBasedOnStatus(currentJobApplication.Status__c, currentJobApplication.Id));
            }

        }
        system.debug('Before-Insert: tasks to be inserted are ::: ' + tasks);
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
                tasks.addAll(assignTasksBasedOnStatus(currentJobApplication.Status__c, currentJobApplication.Id));
            }

        }
        system.debug('Before-Update: tasks to be inserted are ::: ' + tasks);
        insert tasks; // Insert assigned tasks
    }

    /**
     * Assigns tasks based on the provided status.
     * @param currentStatus The status of the job application
     * @param parentId The Job Application ID
     * @return List of tasks assigned based on the status
     */
    private List<Task> assignTasksBasedOnStatus(String currentStatus, Id parentId) {
        List<Task> tasks = new List<Task>();
        if      (currentStatus == 'Saved') {
            tasks.addAll(assignTasks_Saved(parentId));
        }
        else if (currentStatus == 'Applying') {
            tasks.addAll(assignTasks_Applying(parentId));
        }
        else if (currentStatus == 'Applied') {
            tasks.addAll(assignTasks_Applied(parentId));
        }
        else if (currentStatus == 'Interviewing') {
            tasks.addAll(assignTasks_Interviewing(parentId));
        }
        else if (currentStatus == 'Negotiating') {
            tasks.addAll(assignTasks_Negotiating(parentId));
        }
        else if (currentStatus == 'Accepted') {
            tasks.addAll(assignTasks_Accepted(parentId));
        }
        else if (currentStatus == 'Closed') {
            tasks.addAll(assignTasks_Closed(parentId));
        }
        return tasks;
    }

    // Methods assigning tasks for each status

    // Assigns tasks for job applications with status 'Saved'.

    private List<Task> assignTasks_Saved(Id parentId) {
        List<Task> tasks = new List<Task>();
        tasks.add(assignTask(1 , 'Check if the job description aligns with your interests and values' , 'High'  , parentId));
        tasks.add(assignTask(2 , 'Review the highlighted skills to see if the role is a good fit'     , 'Medium', parentId));
        tasks.add(assignTask(3 , 'Research the company or role and mark your excitement level'        , 'Low'   , parentId));

        return tasks;
    }


    // Assigns tasks for job applications with status 'Applying'.

    private List<Task> assignTasks_Applying(Id parentId) {
        List<Task> tasks = new List<Task>();
        tasks.add(assignTask(1 , 'Find and research someone who works at the company and add them as a contact'     , 'Medium'  , parentId));
        tasks.add(assignTask(2 , 'Set up an informational interview to learn more about the role/company'           , 'Medium'  , parentId));
        tasks.add(assignTask(3 , 'Identify potential referrals to help get your application on the top of the pile' , 'Low'     , parentId));
        tasks.add(assignTask(4 , 'Customize your work achievements using the job description keywords'              , 'High'    , parentId));
        tasks.add(assignTask(5 , 'Submit your application on the company website if possible'                       , 'High'    , parentId));

        return tasks;
    }


    // Assigns tasks for job applications with status 'Applied'.

    private List<Task> assignTasks_Applied(Id parentId) {
        List<Task> tasks = new List<Task>();
        tasks.add(assignTask(1 , 'Reach out to the hiring manager or recruiter'                      , 'Medium' , parentId));
        tasks.add(assignTask(2 , 'Follow up on your application via email weekly'                    , 'Medium' , parentId));
        tasks.add(assignTask(3 , 'Continue identifying and saving similar job opportunities'         , 'Low'    , parentId));
        tasks.add(assignTask(4 , 'Set up weekly networking calls to explore similar companies/roles' , 'High'   , parentId));

        return tasks;
    }


    // Assigns tasks for job applications with status 'Interviewing'.

    private List<Task> assignTasks_Interviewing(Id parentId) {
        List<Task> tasks = new List<Task>();
        tasks.add(assignTask(1 , 'Prepare your blurb or \'tell me about yourself\' response' , 'Medium' , parentId));
        tasks.add(assignTask(2 , 'Practice answering behavioral interview questions'         , 'Medium' , parentId));
        tasks.add(assignTask(3 , 'Research the company and your interviewers'                , 'Low'    , parentId));
        tasks.add(assignTask(4 , 'Set up your virtual interview space and test your tech'    , 'High'   , parentId));
        tasks.add(assignTask(5 , 'Send thank you emails within 24 hours'                     , 'High'   , parentId));

        return tasks;
    }

    // Assigns tasks for job applications with status 'Negotiating'.

    private List<Task> assignTasks_Negotiating(Id parentId) {
        List<Task> tasks = new List<Task>();
        tasks.add(assignTask(1 , 'Research your market value and know your numbers' , 'Medium'  , parentId));
        tasks.add(assignTask(2 , 'Prepare your negotiation scripts'                 , 'High'    , parentId));
        tasks.add(assignTask(3 , 'Evaluate your offer and decline or accept'        , 'Low'     , parentId));

        return tasks;
    }

     // Assigns tasks for job applications with status 'Accepted'.

    private List<Task> assignTasks_Accepted(Id parentId) {
        List<Task> tasks = new List<Task>();
        tasks.add(assignTask(1 , 'Plan your resignation if applicable'      , 'Low'     , parentId));
        tasks.add(assignTask(2 , 'Take some time to relax and recharge'     , 'Medium'  , parentId));
        tasks.add(assignTask(3 , 'Prepare for your first day of onboarding' , 'High'    , parentId));

        return tasks;
    }

     // Assigns tasks for job applications with status 'Closed'.

    private List<Task> assignTasks_Closed(Id parentId) {
        List<Task> tasks = new List<Task>();
        tasks.add(assignTask(1 , 'Send a follow-up email thanking the interviewer and asking for feedback' , 'Low'   , parentId));
        tasks.add(assignTask(2 , 'Review your notes and reflect on areas of improvement'                   , 'Medium', parentId));

        return tasks;
    }

    private Task assignTask(Integer daysToDue, String subject, String priority, Id parentId) {

        Task task         = new Task();
        task.Subject      = subject;
        task.ActivityDate = Date.today().addDays(daysToDue);
        task.Priority     = priority;
        task.WhatId       = parentId;

        return task;
    }


}