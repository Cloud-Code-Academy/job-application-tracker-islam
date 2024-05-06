/**
 * Created by islam on 4/18/2024.
 */

public with sharing class InterviewHelper {

    public void checkOverlaps(List<Interview__c> newInterviewList) {

        List<Interview__c> interviews = [SELECT Id, Name, Start_Date_Time__c, End_Date_Time__c FROM Interview__c WHERE Start_Date_Time__c > :Datetime.now()];

        for (Interview__c newInterview: newInterviewList) {

            Long newInterviewStartUnix = newInterview.Start_Date_Time__c.getTime()/1000;
            Long newInterviewEndUnix   = newInterview.End_Date_Time__c.getTime()/1000;


            for (Interview__c existingInterview: interviews) {

                Long existingInterviewStartUnix  = existingInterview.Start_Date_Time__c.getTime()/1000;
                Long existingInterviewEndUnix    = existingInterview.End_Date_Time__c.getTime()/1000;


                if (    (newInterviewStartUnix >= existingInterviewStartUnix && newInterviewStartUnix < existingInterviewEndUnix) ||
                        (newInterviewEndUnix   > existingInterviewStartUnix && newInterviewEndUnix   <= existingInterviewEndUnix)
                ) {
                    newInterview.addError(
                               'Time of this interview overlaps with another interview.'                               + ' <br/>' +
                                    ' Interview Name: '             + existingInterview.Name                                + ' <br/>' +
                                    ' Interview ID: '               + existingInterview.Id                                  + ' <br/>' +
                                    ' Interview Start Date Time: '  + String.valueOf(existingInterview.Start_Date_Time__c)  + ' <br/>' +
                                    ' Interview End Date Time: '    + String.valueOf(existingInterview.End_Date_Time__c), false);

                }
            }
        }
    }

}