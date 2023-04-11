public with sharing class UpdateAllAccountsCA_Batch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext context) {
        // Retrieve data for batch
        return Database.getQueryLocator([SELECT Id, Chiffre_d_affaire__c, (SELECT Id, AccountId, TotalAmount FROM Orders WHERE Status = 'Ordered') FROM Account]);
    }
   
    public void execute(Database.BatchableContext context, List<Account> accListWithOrders) {

        // Update Accounts Chiffre_d_affaire__c
        for (Account acc : accListWithOrders) {
            for (Order ordr : acc.orders) {
                if(ordr.AccountId == acc.Id) {
                    if(acc.Chiffre_d_affaire__c != null) {
                        acc.Chiffre_d_affaire__c += ordr.TotalAmount;
                    } else {
                        acc.Chiffre_d_affaire__c = ordr.TotalAmount; 
                    }
                }
            }
        }

        update accListWithOrders;
    }

    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug(bc);
    }
}