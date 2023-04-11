global with sharing class UpdateAccounts_Scheduleable implements Schedulable{
    global void execute(SchedulableContext ctx) {
        UpdateAllAccountsCA_Batch updateAllAccounts = new UpdateAllAccountsCA_Batch();
        Database.executeBatch(updateAllAccounts);
    }
}