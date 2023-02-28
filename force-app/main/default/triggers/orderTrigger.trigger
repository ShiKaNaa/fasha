trigger orderTrigger on SOBJECT (before update, after update) {

    if(Trigger.isUpdate) {
        List<Order> ordersList = trigger.new;
        
        if(Trigger.isBefore) {

        }
        else if (Trigger.isAfter) {
            
        }
    }

}