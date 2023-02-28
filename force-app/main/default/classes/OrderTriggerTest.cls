@isTest
private with sharing class OrderTriggerTest {
   
    @TestSetup
    static void makeData(){
        // Arrange
        TestDataFactory.generatePriceBookEntry();
        System.debug(TestDataFactory.generatePriceBookEntry());
    }

    @isTest

    private static void setOrderNetAmountTest() {

        // Arrange
        List<Order> ordersListEmpty = new List<Order>();
        // ordersListEmpty[0].ShipmentCost__c = 10;
        // ordersListEmpty[0].TotalAmount = 150;
        insert ordersListEmpty;

        List<Order> ordersList = [SELECT Id, TotalAmount, ShipmentCost__c, NetAmount__c 
                                    FROM Order
                                    ];

        // Act
        Test.startTest();
        // ordersList[0].TotalAmount = 150;
        ordersList[0].ShipmentCost__c = 10;

        update ordersList;
        Test.stopTest();

        // Assert
        System.assertEquals(140, ordersList[0].get('NetAmount__c'));
    }

    @isTest
    private static void setAccountRevenuesUpdateTest() {


        // Act
        Test.startTest();
        Test.stopTest();

        // Assert
    }
}