trigger RepositoryTrigger on Repository__c (after insert, after update) {

    if ( (Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter) {
        RepositoryHandler.handleUpsert();
    }

}