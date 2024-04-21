# Job Application Tracker

## Overview

This capstone project is a comprehensive solution that keeps track of **Job Applications** for users in Salesforce. 

The goal is to be able to track job applications that are found on multiple job boards/sites and synthesize relevant components into one location. 

This system should manage the entire job application lifecycle.

## Data Model

![Job Applications Data Model.drawio.png](images%2FJob%20Applications%20Data%20Model.drawio.png)

## User Journey

A typical user journey will be as follows

Maria is fed up with Ursa Major Solar and is looking for another opportunity

(This is a high-level User Journey, a breakdown of each step will follow)

- Maria navigates to the Home Page where she could see the new Jobs listed in a data table. 
- Maria saves or creates some applications for selected jobs
- Job and Job Application records are created 
- Maria may navigate to Jobs or Job Applications to fill in additional information
- Once Maria receives news of interviews, she could create interview records under each Job Application, and she may also list the potential interviewers
- Maria got to make connections at the companies offering these job listings and create Contact records under each company. She also creates the roles of those individuals for each Job Application. 
- Maria could add notes about job applications
- Maria would check the Calendar view to see upcoming interviews at a glance

## Salesforce Application

Application Name: **Jobs & Applications**


| Tabs             | Home   | Jobs | Job Applications  | Interviews | Calendar | Accounts |
|------------------|--------|------|-------------------|------------|----------|----------|


![application.png](images%2Fapplication.png)


## Components 

### Find Jobs

**LWC Name: findJobs**

Upon navigation to Homepage, a Lightning Web Component loads and fetches jobs from Jooble API. 
The Jobs are displayed in a datatable.

#### Buttons

| Button Label        | Action                                                     |
| ------------------- | ---------------------------------------------------------- |
| Save Jobs           | Creates Job Records                                        |
| Create Applications | Creates Job Records + Creates an Application for reach Job |


![Jooble.png](images%2FJooble.png)

### Take-home Pay Estimation

**LWC Name: takeHomePay**

This component is available on the Job record page. It calculates how much the salary would be after deducting taxes.

Tax Filling Status options are:
* Single
* Married, filing jointly
* Married, filing separately
* Head of household

The component has an input Salary field, it picks up its value from the record's Salary field. Updating this input field does NOT update the record, it is only a means to perform calculations. Feel free to update the Salary field on the record itself and the component will update. 

![TakeHomePayEst.png](images%2FTakeHomePayEst.png)

### Paycheck Breakdown

**LWC Name: paycheckBreakdown**

This component is available on the Job record page. It calculates how much the salary would be at different intervals.

* Weekly
* Bi-Weekly
* Monthly
* 6-Month
* Yearly

To quickly calculate how much these values would be if the salary was different, update either the record's Salary field or Take-home Pay Estimation Salary input.

![PaycheckBreakdown.png](images%2FPaycheckBreakdown.png)

## Background Processes


### Set Primary Contact on Jobs
The following Apex Classes set the primary contact on the jobs when an Application Role is created with Primary checkbox equals true

| APEX Class                        |
| --------------------------------- |
| ApplicationRoleHelper             |
| ApplicationRoleTriggerHandler     |
| ApplicationRoleTriggerHandlerTest |

### Clean Up Stale Job Applications

An asynchronous process that checks if a job application is stale and moves the record status to closed. Updates the notes field that the job application was closed by an automated process.

Stale Criteria:

- Status is not Closed or Accepted

- Follow Date 30 days old or more

| APEX Class                       |
| -------------------------------- |
| cleanUpStaleJobsApplications     |
| cleanUpStaleJobsApplicationsTest |

### Find Jobs

Sets up the integration with Jooble API and fetches Jobs.

| APEX Class          |
| ------------------- |
| fetchJobsFromJooble |
| findJobsHelper      |

### Check Interview Overlaps

Validates new interviews against existing interviews to make sure no overlaps occur and alerts the user. You don't want to have two interviews happen at the same time.

| APEX Class                  |
| --------------------------- |
| InterviewHelper             |
| InterviewTriggerHandler     |
| InterviewTriggerHandlerTest |

### Job Application Tasks

Creates tasks as Job Applications statuses change

The following task records are created based on the application status

SAVED

- Check if the job description aligns with your interests and values
- Review the highlighted skills to see if the role is a good fit
- Research the company or role and mark your excitement level


APPLYING

- Find and research someone who works at the company and add them as a contact
- Set up an informational interview to learn more about the role/company
- Identify potential referrals to help get your application on the top of the pile
- Customize your work achievements using the job description keywords
- Submit your application on the company website if possible

APPLIED

- Reach out to the hiring manager or recruiter
- Follow up on your application via email weekly
- Continue identifying and saving similar job opportunities
- Set up weekly networking calls to explore similar companies/roles

INTERVIEWING

- Prepare your blurb or “tell me about yourself” response
- Practice answering behavioral interview questions
- Research the company and your interviewers
- Set up your virtual interview space and test your tech
- Send thank you emails within 24 hours

NEGOTIATING

- Research your market value and know your numbers
- Prepare your negotiation scripts
- Evaluate your offer and decline or accept

ACCEPTED

- Plan your resignation if applicable
- Take some time to relax and recharge
- Prepare for your first day of onboarding

CLOSED

- Send a follow-up email thanking the interviewer and asking for feedback
- Review your notes and reflect on areas of improvement


| APEX Class                       |
| -------------------------------- |
| jobApplicationHelper             |
| jobApplicationTriggerHandler     |
| jobApplicationTriggerHandlerTest |


### Update Primary Contact on Jobs

Upon creation of a new Job where the company has a related contact, update the Primary Contact on the Job.

The scheduled job would update the Primary Contact if a contact is created under the company at a later time.


|  APEX Class   |
| --- |
|  JobTriggerHelper   |
|  JobTriggerHandler   |
|  JobTriggerHandlerTest   |
|  updatePrimaryContactOnJobs   |
|  updatePrimaryContactOnJobsTest   |



### Remind me about future interviews

Sends a reminder email of interviews happening the following day

| APEX Class             |
| ---------------------- |
| sendReminderEmails     |
| sendReminderEmailsTest |

### Calculate Take Home Pay Estimates

Calculates Take Home Pay which is the Salary after the tax deductions

| APEX Class        |
| ----------------- |
| takeHomePayHelper |







## Custom Objects

### Job


| Field API Name        | Label                | Type                              |
|-----------------------|----------------------|-----------------------------------|
| Company__c            | Company              | Account                           |
| Company_Name__c       | Company Name         | string (255)                      |
| CreatedById           | Created By ID        | User                              |
| CreatedDate           | Created Date         | datetime, required                |
| Description__c        | Description          | textarea (32768)                  |
| Id                    | Record ID            | id (18), required                 |
| IsDeleted             | Deleted              | boolean, required                 |
| Jooble_ID__c          | Jooble ID            | string (100), external id, unique |
| LastActivityDate      | Last Activity Date   | date                              |
| LastModifiedById      | Last Modified By ID  | User                              |
| LastModifiedDate      | Last Modified Date   | datetime, required                |
| LastReferencedDate    | Last Referenced Date | datetime                          |
| LastViewedDate        | Last Viewed Date     | datetime                          |
| Location__c           | Location             | string (255)                      |
| Location_Type__c      | Location Type        | picklist (255), restricted        |
| Name                  | Job Name             | string (80)                       |
| OwnerId               | Owner ID             | Group User                        |
| Position_Title__c     | Position/Title       | string (255)                      |
| Primary_Contact__c    | Primary Contact      | Contact                           |
| Salary__c             | Salary               | currency (18, 0)                  |
| Salary_Lower_Bound__c | Salary Lower Bound   | currency (18, 0)                  |
| Salary_Range__c       | Salary Range         | string (255)                      |
| Salary_Upper_Bound__c | Salary Upper Bound   | currency (18, 0)                  |
| SystemModstamp        | System Modstamp      | datetime, required                |
| URL__c                | URL                  | url (255)                         |



### Job Application


| Field API Name      | Label                | Type                               |
| ------------------- | -------------------- | ---------------------------------- |
| Applicant__c        | Applicant            | User                               |
| Application_Date__c | Application Date     | date                               |
| CreatedById         | Created By ID        | User                               |
| CreatedDate         | Created Date         | datetime, required                 |
| Follow_Up_Date__c   | Follow-Up Date       | date                               |
| Id                  | Record ID            | id (18), required                  |
| IsDeleted           | Deleted              | boolean, required                  |
| Job__c              | Job                  | Job__c                             |
| LastActivityDate    | Last Activity Date   | date                               |
| LastModifiedById    | Last Modified By ID  | User                               |
| LastModifiedDate    | Last Modified Date   | datetime, required                 |
| LastReferencedDate  | Last Referenced Date | datetime                           |
| LastViewedDate      | Last Viewed Date     | datetime                           |
| Name                | Job Application Name | string (80), auto number, required |
| Notes__c            | Notes                | textarea (32768)                   |
| OwnerId             | Owner ID             | Group User                         |
| Rating__c           | Rating               | double (2, 0)                      |
| Status__c           | Status               | picklist (255), restricted         |
| SystemModstamp      | System Modstamp      | datetime, required                 |


### Application Role


| Field API Name     | Label                | Type                               |
| ------------------ | -------------------- | ---------------------------------- |
| Contact__c         | Contact              | Contact                            |
| CreatedById        | Created By ID        | User                               |
| CreatedDate        | Created Date         | datetime, required                 |
| Id                 | Record ID            | id (18), required                  |
| IsDeleted          | Deleted              | boolean, required                  |
| Job_Application__c | Job Application      | Job_Application__c                 |
| LastActivityDate   | Last Activity Date   | date                               |
| LastModifiedById   | Last Modified By ID  | User                               |
| LastModifiedDate   | Last Modified Date   | datetime, required                 |
| LastReferencedDate | Last Referenced Date | datetime                           |
| LastViewedDate     | Last Viewed Date     | datetime                           |
| Name               | Application Name     | string (80), auto number, required |
| OwnerId            | Owner ID             | Group User                         |
| Primary__c         | Primary              | boolean, required                  |
| Role__c            | Role                 | picklist (255), restricted         |
| SystemModstamp     | System Modstamp      | datetime, required                 |


### Interview


| Field API Name       | Label                | Type                               |
| -------------------- | -------------------- | ---------------------------------- |
| CreatedById          | Created By ID        | User                               |
| CreatedDate          | Created Date         | datetime, required                 |
| End_Date_Time__c     | End Date Time        | datetime                           |
| Id                   | Record ID            | id (18), required                  |
| Interview_Details__c | Interview Details    | string (1300)*                     |
| Interview_Type__c    | Interview Type       | picklist (255), restricted         |
| IsDeleted            | Deleted              | boolean, required                  |
| Job_Application__c   | Job Application      | Job_Application__c                 |
| LastActivityDate     | Last Activity Date   | date                               |
| LastModifiedById     | Last Modified By ID  | User                               |
| LastModifiedDate     | Last Modified Date   | datetime, required                 |
| LastReferencedDate   | Last Referenced Date | datetime                           |
| LastViewedDate       | Last Viewed Date     | datetime                           |
| Name                 | Interview Name       | string (80), auto number, required |
| OwnerId              | Owner ID             | Group User                         |
| Start_Date_Time__c   | Start Date Time      | datetime                           |
| SystemModstamp       | System Modstamp      | datetime, required                 |


### Interviewer


| Field API Name     | Label                | Type                               |
| ------------------ | -------------------- | ---------------------------------- |
| CreatedById        | Created By ID        | User                               |
| CreatedDate        | Created Date         | datetime, required                 |
| Id                 | Record ID            | id (18), required                  |
| Interview__c       | Interview            | Interview__c                       |
| Interviewer__c     | Interviewer          | Contact                            |
| IsDeleted          | Deleted              | boolean, required                  |
| LastActivityDate   | Last Activity Date   | date                               |
| LastModifiedById   | Last Modified By ID  | User                               |
| LastModifiedDate   | Last Modified Date   | datetime, required                 |
| LastReferencedDate | Last Referenced Date | datetime                           |
| LastViewedDate     | Last Viewed Date     | datetime                           |
| Name               | Interviewer Name     | string (80), auto number, required |
| OwnerId            | Owner ID             | Group User                         |
| SystemModstamp     | System Modstamp      | datetime, required                 |


## Custom Metadata

### Standard Deductions

| Field API Name        | Label                       | Type                                |
|-----------------------|-----------------------------|-------------------------------------|
| Amount__c             | Amount                      | double (18, 0)                      |
| DeveloperName         | Custom Metadata Record Name | string (40), required               |
| Id                    | Custom Metadata Record ID   | id (18), required                   |
| Label                 | Label                       | string (40)                         |
| Language              | Master Language             | picklist (40), required, restricted |
| ManageableState       | Manageable State            | picklist (40)                       |
| MasterLabel           | Label                       | string (40), required               |
| MasterLabelNorm       | Master Label Normalized     | string (80), required               |
| NamespacePrefix       | Namespace Prefix            | string (15)                         |
| QualifiedApiName      | Qualified API Name          | string (70)                         |
| SystemModstamp        | System Modstamp             | datetime, required                  |
| Tax_Filling_Status__c | Tax Filling Status          | picklist (255), restricted          |

### Tax Brackets


| Field API Name        | Label                       | Type                                |
|-----------------------|-----------------------------|-------------------------------------|
| DeveloperName         | Custom Metadata Record Name | string (40), required               |
| Id                    | Custom Metadata Record ID   | id (18), required                   |
| Label                 | Label                       | string (40)                         |
| Language              | Master Language             | picklist (40), required, restricted |
| ManageableState       | Manageable State            | picklist (40)                       |
| MasterLabel           | Label                       | string (40), required               |
| MasterLabelNorm       | Master Label Normalized     | string (80), required               |
| Maximum_Value__c      | Maximum Value               | double (18, 0)                      |
| Minimum_Value__c      | Minimum Value               | double (18, 0)                      |
| NamespacePrefix       | Namespace Prefix            | string (15)                         |
| QualifiedApiName      | Qualified API Name          | string (70)                         |
| SystemModstamp        | System Modstamp             | datetime, required                  |
| Tax_Filling_Status__c | Tax Filling Status          | picklist (255), restricted          |
| Tax_rate__c           | Tax rate                    | percent (18, 0)                     |


## Custom Settings

### Tax

Holds data for
* Medicare Withholding Rate
* Social Security Rate

| Field API Name               | Label                     | Type                      |
|------------------------------|---------------------------|---------------------------|
| CreatedById                  | Created By ID             | User                      |
| CreatedDate                  | Created Date              | datetime, required        |
| Id                           | Record ID                 | id (18), required         |
| IsDeleted                    | Deleted                   | boolean, required         |
| LastModifiedById             | Last Modified By ID       | User                      |
| LastModifiedDate             | Last Modified Date        | datetime, required        |
| Medicare_Withholding_Rate__c | Medicare Withholding Rate | double (18, 2)            |
| Name                         | Name                      | string (80)               |
| SetupOwnerId                 | Location                  | Organization Profile User |
| Social_Security_Rate__c      | Social Security Rate      | double (18, 2)            |
| SystemModstamp               | System Modstamp           | datetime, required        |

### Jooble

Holds Jooble API Key


| Field API Name               | Label                     | Type                      |
|------------------------------|---------------------------|---------------------------|
| CreatedById                  | Created By ID             | User                      |
| CreatedDate                  | Created Date              | datetime, required        |
| Id                           | Record ID                 | id (18), required         |
| IsDeleted                    | Deleted                   | boolean, required         |
| LastModifiedById             | Last Modified By ID       | User                      |
| LastModifiedDate             | Last Modified Date        | datetime, required        |
| Medicare_Withholding_Rate__c | Medicare Withholding Rate | double (18, 2)            |
| Name                         | Name                      | string (80)               |
| SetupOwnerId                 | Location                  | Organization Profile User |
| Social_Security_Rate__c      | Social Security Rate      | double (18, 2)            |
| SystemModstamp               | System Modstamp           | datetime, required        |


## Color Palette
<table style="border-collapse: collapse;">
  <tr>
    <th style="padding: 10px; border: 1px solid white;">Color Code</th>
    <th style="padding: 10px; border: 1px solid white;">Color</th>
  </tr>
  <tr>
    <td style="padding: 10px; border: 1px solid white;">#FFEDD8</td>
    <td style="padding: 10px; border: 1px solid white;">
      <svg width="100" height="100">
        <circle cx="50" cy="50" r="40" fill="#FFEDD8" />
      </svg>
    </td>
  </tr>
</table>

## Permission Sets

| Permission Set Label | Description                                    |
|----------------------|------------------------------------------------|
| Find Jobs - Jooble   | Alows users to use the Integration with Jooble |

