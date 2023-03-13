trigger CalculMontant on Order (before update) {

	// for (Order o : Trigger.new) {
		
	// }
	Order newOrder = trigger.new[0];
	newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
}