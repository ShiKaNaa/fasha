public with sharing class OrderTriggerHandler {

    /**
    * Method to calculate net amount for orders
    * @param List<Order>
    * @return void
    */
   public static void calculateNetAmountForOrder(List<Order> ordersList) {
        for (Order ordr : ordersList) {
            ordr.NetAmount__c = ordr.TotalAmount - ordr.ShipmentCost__c;
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
            accRelatedId.add(ordr.AccountId);
        }
        
        List<Account> accList = [SELECT ID, Name, Chiffre_d_affaire__c FROM Account WHERE Id IN :accRelatedId];
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
        update accList;
        System.debug(accList);
   }
}
