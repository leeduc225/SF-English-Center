@isTest
public class TotalAmountThisMonthBacthTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        List<Payment__c> payments = new List<Payment__c>();
        // insert 10 accounts
        for (Integer i=0;i<3;i++) {
            accounts.add(new Account(name='Account'+i,
                billingcity='New York', billingcountry='USA'));
        }
        insert accounts;
        // find the account just inserted. add contact for each
        for (Account account : [select id from account]) {
            for (Integer i = 0; i < 3; i++) {
                if (Math.mod(i, 2) == 0) {
                    payments.add(new Payment__c(Name = 'Test'+i, Account__c=account.id, Amount__c = 10, Payment_date__c = date.parse('25/03/2023')));
                } else {
                    payments.add(new Payment__c(Name = 'Test'+i, Account__c=account.id, Amount__c = 10, Payment_date__c = date.parse('25/02/2023')));
                }
            }
        }
        insert payments;
    }
    @isTest static void test() {
        Test.startTest();
        TotalAmountThisMonthBacth tatm = new TotalAmountThisMonthBacth();
        Id batchId = Database.executeBatch(tatm);
        Test.stopTest();
        List<Account> accs = [SELECT Id, This_Month_Total_Payment_Amount__c, (SELECT Id, Amount__c, Final_Amount__c FROM Payments__r WHERE Payment_date__c = THIS_MONTH) FROM Account];
        System.assertEquals(20, accs[0].This_Month_Total_Payment_Amount__c);
        System.assertEquals(20, accs[1].This_Month_Total_Payment_Amount__c);
        System.assertEquals(20, accs[2].This_Month_Total_Payment_Amount__c);
    }
}