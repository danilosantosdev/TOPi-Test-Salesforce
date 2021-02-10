public with sharing class RepositoryHandler {
    
    public static void handleUpsert() {
        
        Id userIdToShare = [SELECT Id FROM User WHERE UserName = 'unicrm@gmail.com' LIMIT 1].Id;
        List<Repository__Share> ltRepShare  = new List<Repository__Share>();

        for (SObject rep : Trigger.new) {
            Repository__Share repShare  = new Repository__Share();

            repShare.ParentId = rep.Id;
            repShare.UserOrGroupId = userIdToShare;
            repShare.AccessLevel = 'Read';
                
            ltRepShare.add(repShare);
        }

        System.debug('ltRepShare: ' + ltRepShare);

        List<Database.SaveResult> ltSR = Database.insert(ltRepShare, false);

        for (Database.SaveResult sr : ltSR) {
            if (!sr.isSuccess()) {
                for (Database.Error err : sr.getErrors()) {
                    System.debug('The following errors has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                }
            }
        }
        

    }

}
