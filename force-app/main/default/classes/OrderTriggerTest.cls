@isTest
private with sharing class OrderTriggerTest {
   
    @TestSetup
    static void makeData(){
        // Arrange
        List<Account> accList = TestDataFactory.generateAccountsList(2);

        Product2 jean = TestDataFactory.generateProduct();
        PricebookEntry pbe = TestDataFactory.generatePriceBookEntry(jean);

        List<Order> ordersList = TestDataFactory.generateOrdersList(pbe, accList, 10, 25);
        OrderItem item = TestDataFactory.generateOrderItemsList(ordersList, pbe, 1);

    }

    @isTest
    private static void setOrderNetAmountTest() {
        // Arrange
        List<Order> ordersList = [SELECT Status, TotalAmount, ShipmentCost__c, NetAmount__c FROM Order];
        List<Order> ordersToUpdate = new List<Order>();
        List<OrderItem> orderItemList = [SELECT UnitPrice FROM OrderItem];

        // Act
        Test.startTest();
        for(Order o : ordersList) {
            o.Status = 'Activated';
            ordersToUpdate.add(o);
            System.debug(o);
        }
        update ordersToUpdate;
        Test.stopTest();

        List<Order> ordersUpdated = [SELECT Id, TotalAmount, ShipmentCost__c, NetAmount__c FROM Order WHERE Status = 'Activated'];
        System.debug(ordersUpdated);
        // Assert
        System.assertEquals(50, ordersUpdated[0].get('NetAmount__c'));
    }

    @isTest
    private static void setAccountRevenuesUpdateTest() {
        // Arrange

        // Act
        Test.startTest();
        Test.stopTest();

        // Assert
    }
}
