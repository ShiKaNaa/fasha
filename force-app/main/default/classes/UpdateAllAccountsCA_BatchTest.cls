
@isTest
private with sharing class UpdateAllAccountsCA_BatchTest {
    
    @TestSetup
    static void makeData(){
        // Arrange
        // Create the 200 accounts to update
        List<Account> accountsList = TestDataFactory.generateAccountsList(200);
        Product2 jean = TestDataFactory.generateProduct();
        PricebookEntry pbe = TestDataFactory.generatePriceBookEntry(jean);
        List<Order> ordersList = TestDataFactory.generateOrdersList(pbe, accountsList, 200, 10);
        OrderItem item = TestDataFactory.generateOrderItemsList(ordersList, pbe, 1);
    }

    @isTest
    private static void update200AccountsTest(){

        // Arrange
        List<Order> ordersList = [SELECT Id, Status FROM Order];

        for(Order ordr : ordersList) {
            ordr.Status = 'Ordered';
        }
        update ordersList;

        // Act
        Test.startTest();
        UpdateAllAccountsCA_Batch updateAccountsBatchTest = new UpdateAllAccountsCA_Batch();
        Id batchId =  Database.executeBatch(updateAccountsBatchTest);
        Test.stopTest();

        // Assert
        List<Account> accountsUpdated = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];  
        System.debug('accountsUpdated : '+ accountsUpdated[0].Chiffre_d_affaire__c);
        System.assertEquals(28000.0, accountsUpdated[0].Chiffre_d_affaire__c);

    }
}