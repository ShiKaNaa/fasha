trigger OrderTrigger on Order (before update, after update) {

    if(Trigger.isUpdate) {
        List<Order> ordersList = Trigger.new;
        Set<Id> relatedAccountsId = new Set<Id>();
        for (Order ordr : ordersList) {
            relatedAccountsId.add(ordr.AccountId);
        }
        
        if(Trigger.isBefore) {
            OrderTriggerHandler.calculateNetAmountForOrder(ordersList);
        }
        // else if (Trigger.isAfter) {
            
        //     OrderTriggerHandler.updateAccountCA(ordersList);
        // }
    }

}