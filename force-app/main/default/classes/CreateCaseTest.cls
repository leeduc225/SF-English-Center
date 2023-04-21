@istest
public class CreateCaseTest {
    @TestSetup
    static void makeData(){
        List<Case> listCase = new List<Case>();
        for (Integer i = 0; i < 200; i++) {
            Case ca = new Case(TextCheck__c = 'Test' + i, Status = 'New', Origin = 'Phone');
            listCase.add(ca);
        }
        insert listCase;
    }

    @isTest
    public static void test_CreateCaseTest() {
        List<Case> listCase = [SELECT Id, TextCheck__c, Status, Origin FROM Case];
        System.assertEquals(200, listCase.size());
    }
}