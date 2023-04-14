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
        this.updateContacWithUserId();
    }
    public void doBeforeDelete(){

    }
    public void doAfterDelete(){
        this.countContact(oldList);
    }

    private void countContact(List<Contact> conList){
        Set<Id> accIds = new Set<Id>();
        for (Contact con : conList) {
            if (!String.isEmpty(con.AccountId)) {
                accIds.add(con.AccountId);
            }
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

    public void updateContacWithUserId() {
        Set<Id> contactIds = new Set<Id>();
        for (Contact ct : this.newList) {
            if (!String.isEmpty(String.valueOf(ct.userId__c)) && ct.userId__c != this.oldMap.get(ct.Id).userId__c) {
                contactIds.add(ct.Id);
            }
        }
        if (contactIds.size() > 0) {
            updateContactByAPI(contactIds);
        }
    }

    @future (callout=true)
    public static void updateContactByAPI(Set<Id> contactIds) {
        List<Contact> contactUpdates = new List<Contact>();
        
        List<Contact> contacts = [SELECT Id, Name, Email, Phone, Website__c, Username__c, Account.Name, userId__c, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry FROM Contact WHERE Id IN :contactIds];
        for(Contact ct : contacts){
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://jsonplaceholder.typicode.com/users/' + ct.userId__c);
            request.setMethod('GET');
            request.setHeader('Content-Type', 'application/json');
            Http http = new Http();
            HTTPResponse response = http.send(request);
            UserWrapper user = (UserWrapper) JSON.deserialize(response.getBody(), UserWrapper.class);
                
            ct.LastName = user.name;
            ct.MobilePhone = user.phone;
            ct.Email = user.email;
            ct.Username__c = user.username;
            contactUpdates.add(ct);
        }

        if (contactUpdates.size() > 0) {
            update contactUpdates;
        }
    }
}