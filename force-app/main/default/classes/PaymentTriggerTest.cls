@isTest
public class PaymentTriggerTest {
    @isTest
    public static void test_setFinalAmount() {
        Payment__c pay = new Payment__c(
            Amount__c = 100, Status__c = 'New'
        );
        insert pay;

        pay.Status__c = 'Done';
        update pay;

        List<Payment__c> newPay = [SELECT Id, Name, Amount__c, Final_Amount__c, Status__c FROM Payment__c];

        System.assertEquals(100, newPay[0].Final_Amount__c);
    }
}