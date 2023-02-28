public with sharing class TestDataFactory {



    public static Pricebook2 generatePricebook() {
        Pricebook2 fashaPriceBook = new Pricebook2(Name = 'Catalogue Fasha');
        insert fashaPriceBook;
        return fashaPriceBook;
    }

    public static Product2 generateProduct() {
        Product2 jean = new Product2(Name = 'Jean stylé', Family = 'Bas');
        insert jean;
        return jean;
    }
    
    public static PricebookEntry generatePriceBookEntry() {
        Pricebook2 pb = generatePricebook();
        Product2 product = generateProduct();

        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = 75,
            IsActive = true
        );
        insert pbe;
        return pbe;
    }

    public static List<Order> generateOrdersList() {
        List<Order> ordersList = new List<Order>();

        return ordersList;
    }
}