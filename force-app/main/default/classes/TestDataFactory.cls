/**
 * Data factory used for tests
 */

@isTest
public with sharing class TestDataFactory {

    /**
    * Method to generate Accounts
    * @param Integer : number of accounts to create
    * @return List<Account>
    */
    public static List<Account> generateAccountsList(Integer numberOfAccountsToCreate) {
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < numberOfAccountsToCreate; i++) {
            Account acc = new Account(Name = 'Test'+i);
            accList.add(acc);
        }
        insert accList;
        return accList;
    }

    /**
    * Method to generate a Pricebook
    * @return Pricebook2
    */
    public static Pricebook2 generatePricebook() {
        Pricebook2 fashaPriceBook = new Pricebook2(Name = 'Catalogue Fasha - Test',
                                                   Description = 'Pricebook for test', 
                                                   IsActive = true);
        insert fashaPriceBook;
        return fashaPriceBook;
    }

    /**
    * Method to generate generateProduct
    * @return Product2
    */
    public static Product2 generateProduct() {
        Product2 jean = new Product2(Name = 'Jean stylé', Family = 'Bas',  IsActive = true);
        insert jean;
        return jean;
    }
    
    
    /**
    * Method to generate generatePriceBookEntry
    * @param Product2 : related product
    * @return PricebookEntry
    */
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

    /**
    * Method to generate Accounts
    * @param PricebookEntry : related pricebook entry
    * @param List<Account> : list of Accounts
    * @param Integer : number of orders to create
    * @param Integer : shipment cost
    * @return List<Order>
    */
    public static List<Order> generateOrdersList(PricebookEntry pbe, List<Account> accList, Integer numberOfOrdersToCreate, Integer shipmentCost) {
        List<Order> ordersList = new List<Order>();
        List<Contract> contractsList = new List<Contract>();

        for (Account acc : accList) {
            Contract contract = new contract(
                AccountId = acc.id,
                Status = 'Draft',
                ContractTerm = 10
            );
            contractsList.add(contract);
        }
        insert contractsList;

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

    /**
    * Method to generate Accounts
    * @param List<Order> : list of Orders
    * @param PricebookEntry : a price book entry
    * @param Integer : quantity of items
    * @return OrderItem
    */
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
