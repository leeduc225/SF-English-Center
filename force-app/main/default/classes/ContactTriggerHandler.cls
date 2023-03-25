public class ContactTriggerHandler {
    private List<Contact> newList;
    private List<Contact> oldList;
    private Map<Id, Contact> newMap;
    private Map<Id, Contact> oldMap;

    public ContactTriggerHandler() {

    }
    public ContactTriggerHandler(List<Contact> newList, List<Contact> oldList, Map<Id, Contact> newMap, Map<Id, Contact> oldMap) {
        this.newList = (newList == null) ? new List<Contact>() : newList;
        this.oldList = (oldList == null) ? new List<Contact>() : oldList;
        this.newMap = (newMap == null) ? new Map<Id, Contact>() : newMap;
        this.oldMap = (oldMap == null) ? new Map<Id, Contact>() : oldMap;
    }

    public void doBeforeInsert(){

    }
    public void doAfterInsert(){
        this.countContact(newList);
    }
    public void doBeforeUpdate(){

    }
    public void doAfterUpdate(){

    }
    public void doBeforeDelete(){

    }
    public void doAfterDelete(){
        this.countContact(oldList);
    }

    private void countContact(List<Contact> conList){
        Set<Id> accIds = new Set<Id>();
        for (Contact con : conList) {
            accIds.add(con.AccountId);
        }
        if (accIds.size() > 0) {
            countContactGroupByAccount(accIds);
        }
    }

    @future
    public static void countContactGroupByAccount(Set<Id> accIds) {
        List<Account> accs = new List<Account>();
        for (AggregateResult rs : [SELECT COUNT(Id) NumContact, AccountId accId FROM Contact WHERE AccountId IN :accIds GROUP BY AccountId]) {
            Integer numberContact = (Integer) rs.get('NumContact');
            Id accId = (Id) rs.get('accId');
            Account udAcc = new Account();
            udAcc.Id = accId;
            udAcc.Number_of_Contacts__c = numberContact;
            accs.add(udAcc);
        }

        if (accs.size() > 0) {
            update accs;
        }
    }
}