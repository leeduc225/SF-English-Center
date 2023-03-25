public class TotalAmountThisMonthBacth implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, This_Month_Total_Payment_Amount__c, (SELECT Id, Amount__c, Final_Amount__c FROM Payments__r WHERE Payment_date__c = THIS_MONTH) FROM Account');
    }
    public void execute(Database.BatchableContext bc, List<Account> accs){
        List<Account> accsToUpdate = new List<Account>();
        for (Account acc : accs) {
            Double totalAmount = 0;
            Account a = new Account();
            a.Id = acc.Id;
            for (Payment__c pay : acc.Payments__r) {
                totalAmount += pay.Amount__c;
            }
            a.This_Month_Total_Payment_Amount__c = totalAmount;
            accsToUpdate.add(a);
        }
        if (accsToUpdate.size() > 0) {
            update accsToUpdate;
        }
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}