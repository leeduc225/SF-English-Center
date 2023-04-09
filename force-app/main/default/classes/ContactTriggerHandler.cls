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
            if (ct.userId__c != this.oldMap.get(ct.Id).userId__c) {
                contactIds.add(ct.Id);
            }
        }
        if (contactIds.size() > 0) {
            updateContactByAPI(contactIds);
        }
    }

    @future (callout=true)
    public static void updateContactByAPI(Set<Id> contactIds) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        List<Contact> contacts = [SELECT Id, Name, Email, Phone, Website__c, Username__c, Account.Name, userId__c, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry FROM Contact WHERE Id IN :contactIds];
        for(Contact ct : contacts){
        String requestBody = '{"name":"' + ct.Name + '" , "email": "' + ct.Email + '" , ' +
        '"phone":"' + ct.Phone +'",  "website":"' + ct.Website__c +'",  ' +
        '"username":"' + ct.Username__c +'", "address": {"street": "' + ct.MailingStreet + '", "city" : "' + ct.MailingCity + '" , "zipcode" : "' + ct.MailingPostalCode + '" },  "company": { "name" :"' + ct.Account.name + '"}}'; 
        
        request.setEndpoint('https://jsonplaceholder.typicode.com/users/' + ct.userId__c);
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(requestBody); 
        
        HTTPResponse response = http.send(request);
            
        if (response.getStatusCode() == 200) {
           Map<String, Object> updatedContact = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           System.debug(updatedContact);
        }
        else {
            System.debug('Error updating data: ' + response.getStatus());
        }
        }
    }
}