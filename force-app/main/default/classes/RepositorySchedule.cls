global with sharing class RepositorySchedule implements Schedulable {
    global void execute(SchedulableContext SC) {
        RepositoryController.getMostStarred();

        // Run the command above in the developer console to schedule the class once a day at midnight
        //System.schedule('Job to get most starred github repositories', '0 0 0 1/1 * ? *', new RepositorySchedule());
    }
}
