public with sharing class UpdateAllAccountsCA_Batch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext context) {
        // Select all Account that have a 
        return Database.getQueryLocator([SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')]);
    }
   
    public void execute(Database.BatchableContext context, List<Account> accList) {

        List<Order> ordersList = [SELECT Id, AccountId, TotalAmount FROM Order];

        // Ca serait mieux de faire appel à mon updateAccountCA ou de créer un service ?
        for (Account acc : accList) {
            for (Order ordr : ordersList) {
                if(ordr.AccountId == acc.Id) {
                    if(acc.Chiffre_d_affaire__c != null) {
                        acc.Chiffre_d_affaire__c += ordr.NetAmount__c;
                    } else {
                        acc.Chiffre_d_affaire__c = ordr.NetAmount__c; 
                    }
                }
            }
        }

        update accList;
    }

    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug(bc);
    }
}