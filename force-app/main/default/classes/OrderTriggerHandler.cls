public with sharing class OrderTriggerHandler {

    /**
    * Method to calculate net amount for orders
    * @param List<Order>
    * @return void
    */
   public static void calculateNetAmountForOrder(List<Order> ordersList) {
        for (Order ordr : ordersList) {
            if(ordr.ShipmentCost__c != null) {
                ordr.NetAmount__c = ordr.TotalAmount - ordr.ShipmentCost__c;
            } else {
                ordr.NetAmount__c = ordr.TotalAmount;
            }
        }
   }

   /**
    * Method to update Account CA
    * @param List<Order>
    * @return void
    */
   public static void updateAccountCA(List<Order> ordersList) {
        Map<Id, Order> mapIdOrder = new Map<Id, Order>(ordersList);
        Set<Id> accRelatedId = new Set<Id>();
        for (Order ordr : mapIdOrder.values()) {
            //TODO: changer 'Draft' a 'Ordered'
            if(ordr.get('Status') == 'Ordered') {
                accRelatedId.add(ordr.AccountId);
            }
        }
        
        // REMARQUE: j'ai l'impression que ma solition de base est plus rapide que (exec time plus rapide)
        List<Account> accList = [SELECT ID, Name, Chiffre_d_affaire__c FROM Account WHERE Id IN :accRelatedId];
        // Map<Id,Account> mapIdToAccount = new  Map<Id,Account>([SELECT ID, Name, Chiffre_d_affaire__c FROM Account WHERE Id IN :accRelatedId]);
        for (Order ordr : mapIdOrder.values()) {
            // Account currentAcc = mapIdToAccount.get(ordr.AccountId);
            // System.debug(currentAcc);
            // if (currentAcc != null) {
            //     if(currentAcc.Chiffre_d_affaire__c != null) {
            //         currentAcc.Chiffre_d_affaire__c += ordr.NetAmount__c;
            //     } else {
            //         currentAcc.Chiffre_d_affaire__c = ordr.NetAmount__c; 
            //     }   
            // }

            for(Account acc : accList) {
                if(acc.Id == ordr.get('AccountId')) {
                    if(acc.Chiffre_d_affaire__c != null) {
                        acc.Chiffre_d_affaire__c += ordr.NetAmount__c;
                    } else {
                        acc.Chiffre_d_affaire__c = ordr.NetAmount__c; 
                    }
                }
            }
        }

        // update mapIdToAccount.values();
        update accList;
   }
}
