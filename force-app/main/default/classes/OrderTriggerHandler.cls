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
            if(ordr.get('Status') == 'Ordered') {
                accRelatedId.add(ordr.AccountId);
            }
        }
        
        // Retrieve only related accounts
        List<Account> accList = [SELECT ID, Name, Chiffre_d_affaire__c FROM Account WHERE Id IN :accRelatedId];

        // For each order update related accounts Chiffre_d_affaire__c
        for (Order ordr : mapIdOrder.values()) {
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
