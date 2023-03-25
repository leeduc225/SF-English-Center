public with sharing class TotalAmountThisMonthBacthSchedule implements Schedulable {
    public void execute(SchedulableContext ctx) {
        TotalAmountThisMonthBacth tatm = new TotalAmountThisMonthBacth();
        Database.executeBatch(tatm);
    }
}