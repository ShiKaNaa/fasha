@IsTest
public with sharing class TestDataFactory {

    public static List<Account> generateAccountsList(Integer numberOfAccountsToCreate) {
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < numberOfAccountsToCreate; i++) {
            Account acc = new Account(Name = 'Test'+i);
            accList.add(acc);
        }
        insert accList;
        return accList;
    }

    // // J'en aurai peut-être pas besoin
    // public static Pricebook2 getStandardPB() {
    //     Pricebook2 standardPB = [SELECT ID FROM Pricebook2 WHERE isStandard = true LIMIT 1]; 
    //     return standardPB;
    // }

    public static Pricebook2 generatePricebook() {
        Pricebook2 fashaPriceBook = new Pricebook2(Name = 'Catalogue Fasha - Test',
                                                   Description = 'Pricebook for test', 
                                                   IsActive = true);
        insert fashaPriceBook;
        return fashaPriceBook;
    }

    public static Product2 generateProduct() {
        Product2 jean = new Product2(Name = 'Jean stylé', Family = 'Bas',  IsActive = true);
        insert jean;
        return jean;
    }
    
    // @isTest
    public static PricebookEntry generatePriceBookEntry(Product2 product) {
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = 75,
            IsActive = true
        );
        insert pbe;
        return pbe;
    }

    public static List<Order> generateOrdersList(PricebookEntry pbe, List<Account> accList, Integer numberOfOrdersToCreate, Integer shipmentCost) {
        List<Order> ordersList = new List<Order>();

        for(Integer i = 0; i < numberOfOrdersToCreate; i++){
            Order ordr = new Order(AccountId = accList[0].Id,
                                Status = 'Draft',
                                EffectiveDate = Date.today(),
                                Pricebook2Id = pbe.Pricebook2Id,
                                shipmentCost__c = shipmentCost);
            ordersList.add(ordr);
        }
        insert ordersList;
        return ordersList;
    }

    public static OrderItem generateOrderItemsList(List<Order> ordersList, PricebookEntry pbe, Integer quantity) {

        List<OrderItem> orderItemList = new List<OrderItem>();
        OrderItem itemToReturn;

        for(Order o : ordersList) {
            itemToReturn = new OrderItem(OrderId = o.Id,
                                         PricebookEntryId = pbe.Id,
                                         Quantity = quantity,
                                         UnitPrice = pbe.UnitPrice);
            orderItemList.add(itemToReturn);
        }
        insert orderItemList;
        update ordersList;
        return itemToReturn;
    }

}
