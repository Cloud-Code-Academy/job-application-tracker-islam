/**
 * Created by islam on 4/20/2024.
 */

@IsTest
private class sendReminderEmailsTest {
    @IsTest
    static void testSendReminderEmails() {

        Id standardUserProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id;
        String timeZoneSidKey    = 'America/New_York';
        String localeSidKey      = 'en_US';
        String languageLocaleKey = 'en_US';
        String emailEncodingKey  = 'UTF-8';


        User userWithInterviews   = new User(
                FirstName         = 'Test',
                LastName          = 'userWithInterviews',
                Username          = 'capstone01_testuser1@example.com',
                Email             = 'testuser1@example.com',
                Alias             = 'TU1',
                TimeZoneSidKey    = timeZoneSidKey,
                LocaleSidKey      = localeSidKey,
                EmailEncodingKey  = emailEncodingKey,
                ProfileId         = standardUserProfileId,
                LanguageLocaleKey = languageLocaleKey
        );

        User userWithoutInterviews  = new User(
                FirstName           = 'Test',
                LastName            = 'userWithoutInterviews',
                Username            = 'capstone02_testuser2@example.com',
                Email               = 'testuser2@example.com',
                Alias               = 'TU2',
                TimeZoneSidKey      = timeZoneSidKey,
                LocaleSidKey        = localeSidKey,
                EmailEncodingKey    = emailEncodingKey,
                ProfileId           = standardUserProfileId,
                LanguageLocaleKey   = languageLocaleKey

        );

        List<User> users = new List<User>();
        users.add(userWithInterviews);
        users.add(userWithoutInterviews);

        insert users;
        System.debug('inserted users are ::: ' + users);

        Job__c job = new Job__c(Name='Salesforce Developer');
        insert job;

        Job_Application__c jobApplication = new Job_Application__c(Job__c = job.Id, Status__c='Saved', Applicant__c=userWithInterviews.Id);
        insert jobApplication;

        List<Interview__c> interviews = new List<Interview__c>();
        for (Integer i = 0; i < 4; i++) {

            Integer startHour       = 9 + i;
            Date startDate          = Date.today().addDays(1);
            Time startTime          = Time.newInstance(startHour, 0, 0, 0);

            Datetime startDateTime  = Datetime.newInstance(startDate, startTime);
            Datetime endDateTime    = startDateTime.addHours(1);


            Interview__c interview = new Interview__c(  Job_Application__c = jobApplication.Id,
                                                        Start_Date_Time__c = startDateTime,
                                                        End_Date_Time__c   = endDateTime);
            interviews.add(interview);
        }
        insert interviews;

        Test.startTest();
        sendReminderEmails.scheduleJob();
        Test.stopTest();

        List<EmailMessage> emailMessages = [SELECT Id, Subject FROM EmailMessage];
        System.debug('emailMessages' + emailMessages);

        System.assert(emailMessages.size() == 1);
        for (EmailMessage currentEmailMessage: emailMessages) {
            System.assertEquals('Tomorrow\'s Interviews', currentEmailMessage.Subject);
        }

    }
}