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
    // if (Trigger.isUpdate) {
    //     if (Trigger.isBefore) {
    //         for(Payment__c pay : Trigger.new){
    //             if('Done'.equals(pay.Status__c) && pay.Final_Amount__c == null){
    //                 pay.Final_Amount__c = pay.Amount__c;
    //             }
    //         }
    //         for (Payment__c payOld : Trigger.old) {
    //             if ('Done'.equals(payOld.Status__c) && !payOld.Status__c.equals(Trigger.newMap.get(payOld.Id).Status__c)) {
    //                 Trigger.newMap.get(payOld.Id).addError('Not allowed to change status from Done to other values.');
    //             }
    //         }
    //     }
    // }
    // if (Trigger.isInsert) {
    //     if (Trigger.isAfter) {
    //         List<Task> listTask = new List<Task>(); 
    //         for (Payment__c pay : Trigger.new) {
    //             if ('Chuyển khoản'.equals(pay.Payment_method__c)) {
    //                 Task taskPay = new Task(
    //                     Subject = 'Verify payment ' + pay.Name,
    //                     Priority = 'High',
    //                     OwnerId = pay.OwnerId,
    //                     ActivityDate = pay.Payment_date__c.addDays(1),
    //                     Status = 'Not Started',
    //                     WhatId = pay.Id
    //                 );
    //                 listTask.add(taskPay);
    //             }
    //         }
    //         insert listTask;
    //     }
    // }
}