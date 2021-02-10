public with sharing class RepositoryController {

    @AuraEnabled
    public static List<Repository__c> getRepositories() {
        return [SELECT Name, Number_of_Stars__c, Number_of_Forks__c, Repository_ID__c FROM Repository__c];
    }

    @future(callout=true)
    public static void getMostStarred() {
        String endPoint = 'https://api.github.com/search/repositories?q=language:Apex&sort=stars&page=1';

        try {

            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endPoint);
            request.setMethod('GET');
            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                List<Repository__c> ltRepository = new List<Repository__c>();

                Repository repository = (RepositoryController.Repository)JSON.deserialize(response.getBody(), RepositoryController.Repository.class);
                List<Items> items = (List<Items>) repository.items;

                if (!items.isEmpty()) {
                    for (Items item : items) {
                        ltRepository.add(
                            new Repository__c(
                                Name = item.name,
                                Repository_ID__c = item.id,
                                Number_of_Stars__c = Decimal.valueOf(item.stargazers_count),
                                Number_of_Forks__c = Decimal.valueOf(item.forks_count)
                            )
                        );
                    }
                }

                if (!ltRepository.isEmpty()) upsert ltRepository Repository_ID__c;

            }

        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }

    public class Repository {
        public Integer total_count;
        public Boolean incomplete_results;
        public List<Items> items;
    }

    public class Items {    
        public String id;
        public String name;
        public Integer stargazers_count;
        public String forks_count;
    }
}
