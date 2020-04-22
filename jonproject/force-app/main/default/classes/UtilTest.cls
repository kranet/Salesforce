@isTest
public with sharing class UtilTest {
    @testSetup 
    static void setup() {
        TestDataFactory.createAccount(3);
    }
    @isTest
    public static void convertSetTest(){
        Set<String> inputSet = new Set<String> ((new Map<String, Account>([SELECT Id FROM Account LIMIT 2])).keySet());
        Set<Id> outputSet = Util.convertSet(inputSet);
        Test.startTest();
        System.assertEquals(outputSet.size(), 2);
        Set<String> reversedOutputSet = Util.convertSet(outputSet);
        System.assertEquals(reversedOutputSet.size(), 2);
        Test.stopTest();
    }
    public static void setifyListTest(){
        Set<Id> accIdSet= Util.setifyList([SELECT ID FROM ACCOUNT LIMIT 2]);
        System.assertEquals(accIdSet.size(), 2);
    }
}