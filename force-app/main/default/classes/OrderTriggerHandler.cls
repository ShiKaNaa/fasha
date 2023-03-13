public with sharing class OrderTriggerHandler {

   public static void calculateNetAmountForOrder(List<Order> ordersList) {
        for (Order ordr : ordersList) {
            ordr.NetAmount__c = ordr.TotalAmount - ordr.ShipmentCost__c;
        }
   }

}
