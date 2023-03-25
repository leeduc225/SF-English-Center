public class UpdateFieldNumberOfPayment implements Queueable {
    private Set<Id> accIds;
    public UpdateFieldNumberOfPayment(Set<Id> accIds) {
        this.accIds = accIds;
    }

    public void execute(QueueableContext context) {
        List<Account> accs = new List<Account>();
        for (AggregateResult rs : [SELECT COUNT(Id) NumPayment, Account__c accId FROM Payment__c WHERE Status__c = 'Done' AND Account__c IN :accIds GROUP BY Account__c]) {
            Integer numberPay = (Integer) rs.get('NumPayment');
            Id accId = (Id) rs.get('accId');
            Account udAcc = new Account();
            udAcc.Id = accId;
            udAcc.Number_of_Payment__c = numberPay;
            accs.add(udAcc);
        }
        if (accs.size() > 0) {
            update accs;
        }
    }
}