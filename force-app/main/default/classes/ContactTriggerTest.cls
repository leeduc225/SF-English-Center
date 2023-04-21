@isTest
public class ContactTriggerTest {
    @isTest
    public static void test_countContactGroupByAccount_01() {
        Account acc1 = new Account(Name = 'AccountTest1');
        insert acc1;
        Account acc2 = new Account(Name = 'AccountTest2');
        insert acc2;

        Contact con1 = new Contact(LastName = 'Contact1', AccountId = acc1.Id);
        Contact con2 = new Contact(LastName = 'Contact2', AccountId = acc2.Id);
        List<Contact> listCon = new List<Contact>();
        listCon.add(con1);
        listCon.add(con2);

        Test.startTest();
        insert listCon;
        Test.stopTest();

        List<Account> listAcc = [SELECT Id, Name, Number_of_Contacts__c FROM Account];
        System.assertEquals(1, listAcc[0].Number_of_Contacts__c);
        System.assertEquals(1, listAcc[1].Number_of_Contacts__c);
    }
    
    @isTest
    public static void test_countContactGroupByAccount_02() {
        Account acc1 = new Account(Name = 'AccountTest1');
        insert acc1;
        Account acc2 = new Account(Name = 'AccountTest2');
        insert acc2;

        Contact con1 = new Contact(LastName = 'Contact1', AccountId = acc1.Id);
        Contact con2 = new Contact(LastName = 'Contact2', AccountId = acc2.Id);
        List<Contact> listCon = new List<Contact>();
        listCon.add(con1);
        listCon.add(con2);
        insert listCon;

        Test.startTest();
        delete con1;
        Test.stopTest();

        List<Account> listAcc = [SELECT Id, Name, Number_of_Contacts__c FROM Account];
        System.assertEquals(null, listAcc[0].Number_of_Contacts__c);
        System.assertEquals(1, listAcc[1].Number_of_Contacts__c);
    }
}