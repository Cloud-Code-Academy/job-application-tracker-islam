/**
 * Created by islam on 4/18/2024.
 */

@IsTest
private class InterviewTriggerHandlerTest {
    @IsTest
    static void testInterviewTrigger_checkOverlaps() {

        Integer thisYear  = Date.today().year();
        Integer thisMonth = Date.today().month();
        Integer tomorrow  = Date.today().day() + 1;

        String errorMessage = '';


        // Create the first interview
        Interview__c interview1     = new Interview__c(
                Start_Date_Time__c  = Datetime.newInstance(thisYear, thisMonth, tomorrow, 22, 0, 0),
                End_Date_Time__c    = Datetime.newInstance(thisYear, thisMonth, tomorrow, 23, 0, 0)
        );
        insert interview1;

        // Create the second interview (ensure it overlaps with the first interview time)
        Interview__c interview2     = new Interview__c(
                Start_Date_Time__c  = Datetime.newInstance(thisYear, thisMonth, tomorrow, 22, 0, 0),
                End_Date_Time__c    = Datetime.newInstance(thisYear, thisMonth, tomorrow, 23, 0, 0)
        );

        // Create the third interview, starts before first interview but still overlaps
        Interview__c interview3     = new Interview__c(
                Start_Date_Time__c  = Datetime.newInstance(thisYear, thisMonth, tomorrow, 21, 30, 0),
                End_Date_Time__c    = Datetime.newInstance(thisYear, thisMonth, tomorrow, 23, 0, 0)
        );

        try {
            insert interview2;
        } catch (DmlException dmlException) {
            errorMessage = dmlException.getDmlMessage(0);
        }

        System.assert(errorMessage.contains('overlaps'));
        System.assert(errorMessage.contains(String.valueOf(interview1.Start_Date_Time__c)));
        System.assert(errorMessage.contains(String.valueOf(interview1.End_Date_Time__c)));

        try {
            insert interview3;
        } catch (DmlException dmlException) {
            errorMessage = dmlException.getDmlMessage(0);
        }

        System.assert(errorMessage.contains('overlaps'));
        System.assert(errorMessage.contains(String.valueOf(interview1.Start_Date_Time__c)));
        System.assert(errorMessage.contains(String.valueOf(interview1.End_Date_Time__c)));
    }
}