trigger PaymentTrigger on Payment__c (after insert, before update, after update) {
    PaymentTriggerHandler handler = new PaymentTriggerHandler(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
    
    if( Trigger.isInsert ) {
        if(Trigger.isBefore) {
            handler.doBeforeInsert();
        }
        else {
            handler.doAfterInsert();
        }
    }
    if ( Trigger.isUpdate ) {
        if(Trigger.isBefore) {
            handler.doBeforeUpdate();
        }
        else {
            handler.doAfterUpdate();
        }
    }
    
}
