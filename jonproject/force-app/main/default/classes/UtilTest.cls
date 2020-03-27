@isTest
public with sharing class UtilTest {
    @testSetup 
    static void setup() {
        TestDataFactory.createAccount(3);
    }
    @isTest
    public static void constructWhereQueryFromFieldNameToValueMap_Test() {
        Map<String, String> queryFilterMap = new Map<String,String>();
        queryFilterMap.put('Name', 'Jonis');
        queryFilterMap.put('Phone', '0702288452');
        queryFilterMap.put('Id', '12121212');
        Util.Parameters parameters = new Util.Parameters('Account', queryFilterMap);
        String whereQueryString = Util.constructWhereQuery(parameters);
    }
    @isTest
    public static void generalQueryWithList_Test() {
        List<String> desiredFields = new List<String>{'Id', 'Name', 'AccountNumber'};
        Util.Parameters params = new Util.Parameters('Account', desiredFields);
        List<Account> accountList = (List<Account>) Util.generalQuery(params);
        Test.startTest();
        Map<String, Object> fieldToValueMap = accountList.get(0).getPopulatedFieldsAsMap();
        Set<String> fieldSet = fieldToValueMap.keySet();
        Set<String> fieldSetInitial = new Set<String> (desiredFields);
        Test.stopTest();
        System.assert(fieldSetInitial.containsAll(fieldSet), 'Queried field missing');
    }
    @isTest
    public static void generalQueryWithMapWithoutDesiredFields_Test() {
        Map<String,String> queryFilterMap = new Map<String,String>();
        queryFilterMap.put('Name', 'Jonis');
        queryFilterMap.put('Phone', '0702288452');
        queryFilterMap.put('Id', '12121212');
        Util.Parameters params = new Util.Parameters('Account', queryFilterMap);
        List<Account> accountList = (List<Account>) Util.generalQuery(params);
    }
}