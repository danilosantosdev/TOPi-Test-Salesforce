@IsTest
public class RepositoryControllerTest {
    
    @TestSetup
    static void makeData() {
        // new repositories
        Repository__c rep1 = new Repository__c(
            Name = 'Apex Tests',
            Number_of_Stars__c = 1000,
            Number_of_Forks__c = 78,
            Repository_ID__c = '123456'
        );

        Repository__c rep2 = new Repository__c(
            Name = 'Apex Design Pattern',
            Number_of_Stars__c = 561,
            Number_of_Forks__c = 52,
            Repository_ID__c = '258522'
        );

        List<Repository__c> ltRepository = new List<Repository__c>{rep1, rep2};
    
        Insert ltRepository;
    }

    @IsTest
    static void getRepositoriesTest() {
        List<Repository__c> ltRepository = RepositoryController.getRepositories();

        Test.startTest();
            System.assertEquals(2, ltRepository.size());
            System.assertEquals('Apex Tests', ltRepository[0].Name);
        Test.stopTest();
        
    }

    @IsTest
    static void getMostStarredTest() {

        Test.startTest();

            Test.setMock(HttpCalloutMock.class, new RepositoryControllerCalloutMock());

            RepositoryController.getMostStarred();

            System.assert([SELECT Name, Number_of_Stars__c, Number_of_Forks__c, Repository_ID__c FROM Repository__c].size() > 0);

        Test.stopTest();
        
    }

}
