trigger ContactTrigger on Contact (after insert, after delete) {
    ContactTriggerHandler handler = new ContactTriggerHandler(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
    
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
    if ( Trigger.isDelete ) {
        if(Trigger.isBefore) {
            handler.doBeforeDelete();
        }
        else {
            handler.doAfterDelete();
        }
    }
    
}