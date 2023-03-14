@isTest
private with sharing class OrderTriggerTest {
   
    @TestSetup
    static void makeData(){
        // Arrange
        List<Account> accList = TestDataFactory.generateAccountsList(1);

        Product2 jean = TestDataFactory.generateProduct();
        PricebookEntry pbe = TestDataFactory.generatePriceBookEntry(jean);

        List<Order> ordersList = TestDataFactory.generateOrdersList(pbe, accList, 10, 25);
        OrderItem item = TestDataFactory.generateOrderItemsList(ordersList, pbe, 1);

    }

    @isTest
    private static void setOrderNetAmountTest() {
        // Arrange
        List<Order> ordersList = [SELECT AccountId, Status, TotalAmount, ShipmentCost__c, NetAmount__c FROM Order];
        List<Order> ordersToUpdate = new List<Order>();

        // Act
        Test.startTest();
        for(Order o : ordersList) {
            o.Status = 'Activated';
            ordersToUpdate.add(o);
        }
        update ordersToUpdate;
        Test.stopTest();

        List<Order> ordersUpdated = [SELECT Id, TotalAmount, ShipmentCost__c, NetAmount__c FROM Order WHERE Status = 'Activated'];
        // Assert
        System.assertEquals(50, ordersUpdated[0].get('NetAmount__c'));


    }

    @isTest
    private static void setAccountRevenuesUpdateTest() {

        // Arrange

        // Act
        Test.startTest();
        Account accountToAppendOrder = [SELECT Id, Chiffre_d_affaire__c FROM Account LIMIT 1];
        Test.stopTest();


        // Assert
        List<Account> accts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :accountToAppendOrder.Id];
        System.assertEquals(500, accts[0].Chiffre_d_affaire__c);
    }
}
