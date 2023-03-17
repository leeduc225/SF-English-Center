public with sharing class PaymentTriggerHandler {
    private List<Payment__c> newList;
    private List<Payment__c> oldList;
    private Map<Id, Payment__c> newMap;
    private Map<Id, Payment__c> oldMap;

    public PaymentTriggerHandler() {

    }
    public PaymentTriggerHandler(List<Payment__c> newList, List<Payment__c> oldList, Map<Id, Payment__c> newMap, Map<Id, Payment__c> oldMap) {
        this.newList = (newList == null) ? new List<Payment__c>() : newList;
        this.oldList = (oldList == null) ? new List<Payment__c>() : oldList;
        this.newMap = (newMap == null) ? new Map<Id, Payment__c>() : newMap;
        this.oldMap = (oldMap == null) ? new Map<Id, Payment__c>() : oldMap;
    }
    
    public void doBeforeInsert(){

    }
    public void doAfterInsert(){
        this.autoAssignTask();
    }
    public void doBeforeUpdate(){
        this.setFinalAmount();
        this.preventStatusChange();
    }
    public void doAfterUpdate(){

    }

    // Tự động update Final Amount = Amount khi Status chuyển thành Done nếu Final Amount không được nhập dữ liệu
    private void setFinalAmount() {
        for(Payment__c pay : this.newList){
            if('Done'.equals(pay.Status__c) && pay.Final_Amount__c == null){
                pay.Final_Amount__c = pay.Amount__c;
            }
        }
    }

    // Người dùng không được phép chuyển status từ Done sang các giá trị khác
    private void preventStatusChange() {
        for (Payment__c payOld : this.oldList) {
            if ('Done'.equals(payOld.Status__c) && !payOld.Status__c.equals(this.newMap.get(payOld.Id).Status__c)) {
                Trigger.newMap.get(payOld.Id).addError('Not allowed to change status from Done to other values.');
            }
        }
    }

    // Tự động tạo task cho owner khi một payment được tạo ra với payment method là Chuyển Khoản
    private void autoAssignTask() {
        List<Task> listTask = new List<Task>(); 
            for (Payment__c pay : this.newList) {
                if ('Chuyển khoản'.equals(pay.Payment_method__c)) {
                    Task taskPay = new Task(
                        Subject = 'Verify payment ' + pay.Name,
                        Priority = 'High',
                        OwnerId = pay.OwnerId,
                        ActivityDate = pay.Payment_date__c.addDays(1),
                        Status = 'Not Started',
                        WhatId = pay.Id
                    );
                    listTask.add(taskPay);
                }
            }
        insert listTask;
    }
}