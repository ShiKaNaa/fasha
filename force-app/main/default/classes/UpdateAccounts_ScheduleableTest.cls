@isTest
private with sharing class UpdateAccounts_ScheduleableTest {

    @isTest 
    static void updateAccountScheduleableTest() {
        Test.startTest();
        // Execution du schedulable dans 1 minute
        String cronExp = '0 0 0/1 * * ?';
        String jobId = System.schedule('Update Accounts', cronExp, new UpdateAccounts_Scheduleable());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobId];
        Test.stopTest();
        System.assertEquals(cronExp, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
}