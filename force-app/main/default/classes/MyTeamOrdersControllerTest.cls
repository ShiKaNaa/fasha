@isTest
private with sharing class MyTeamOrdersControllerTest {


    @TestSetup
    static void makeData(){
        // Arrange
        // Create the 200 accounts to update
        List<Account> accountsList = TestDataFactory.generateAccountsList(10);
        Product2 jean = TestDataFactory.generateProduct();
        PricebookEntry pbe = TestDataFactory.generatePriceBookEntry(jean);
        List<Order> ordersList = TestDataFactory.generateOrdersList(pbe, accountsList, 10, 15);
        OrderItem item = TestDataFactory.generateOrderItemsList(ordersList, pbe, 1);
    }

    @isTest
    private static void teamOrderTest() {

        // Arrange
        List<Order> ordersList = [SELECT Id, Status FROM ORDER];

        for(Order order : ordersList) {
            order.Status = 'Ordered'; 
        }

        update ordersList;

        Test.startTest();
        MyTeamOrdersController teamResults = new MyTeamOrdersController();
        Test.stopTest();

        Decimal expectedTeamResults;
        System.assertEquals(750.0, teamResults.SumOders);
    }

    @isTest 
    private static void teamWithNoOrderTest() {
        Test.startTest();
        MyTeamOrdersController teamResults = new MyTeamOrdersController();
        Test.stopTest();

        Decimal expectedTeamResults;
        System.assertEquals(null, teamResults.SumOders);
    }
}