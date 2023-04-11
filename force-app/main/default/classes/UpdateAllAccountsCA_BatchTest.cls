
@isTest
private with sharing class UpdateAllAccountsCA_BatchTest {

    @isTest
    private static void update200AccountsTest(){

        // Arrange
        // Create the 200 accounts to update
        List<Account> accountsList = TestDataFactory.generateAccountsList(200);
        Product2 jean = TestDataFactory.generateProduct();
        PricebookEntry pbe = TestDataFactory.generatePriceBookEntry(jean);
        List<Order> ordersList = TestDataFactory.generateOrdersList(pbe, accountsList, 200, 10);
        OrderItem item = TestDataFactory.generateOrderItemsList(ordersList, pbe, 1);


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
        List<Account> accountsUpdated = [SELECT Id, Chiffre_d_affaire__c, (SELECT Id, Status, TotalAmount FROM Orders 
                                  WHERE Status = 'Ordered') 
                                  FROM Account 
                                  WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];  
        System.debug('accountsUpdated : '+ accountsUpdated[0].Chiffre_d_affaire__c);
        System.assertEquals(28000.0, accountsUpdated[0].Chiffre_d_affaire__c);

    }
}