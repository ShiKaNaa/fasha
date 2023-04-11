trigger OrderTrigger on Order (before update, after update) {

    if(Trigger.isUpdate) {
        List<Order> ordersList = Trigger.new;     
        if(Trigger.isBefore) {
            OrderTriggerHandler.calculateNetAmountForOrder(ordersList);
        }
        else if (Trigger.isAfter) {
            OrderTriggerHandler.updateAccountCA(ordersList);
        }
    }

}