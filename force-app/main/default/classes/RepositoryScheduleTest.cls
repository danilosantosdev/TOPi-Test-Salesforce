@IsTest
public class RepositoryScheduleTest {
    
    public static final String CRON_TIME = '0 0 0 1/1 * ? *';

    @IsTest
    static void testScheduledJob() {
        
        Test.startTest();
            String jobId = System.schedule('Get most starred Apex repositories', CRON_TIME, new RepositorySchedule());
            List<Repository__c> ltRepository = [SELECT Id FROM Repository__c];

            System.assertEquals(0, ltRepository.size(), 'There are no repositories yet');
        Test.stopTest();

        List<Repository__c> ltRepositoryUpToDate = [SELECT Id FROM Repository__c];
        System.assert(ltRepositoryUpToDate.size() > 0);
        
    }

}
