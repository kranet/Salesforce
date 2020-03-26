@isTest
public with sharing class UtilTest {
    @testSetup 
    static void setup() {
        TestDataFactory.createAccount(3);
    }
    @isTest
    public static void constructWhereQueryFromFieldNameToValueMap_Test() {
        Map<String,String> inputMap = new Map<String,String>();
        inputMap.put('Name', 'Jonis');
        inputMap.put('Phone', '0702271905');
        inputMap.put('Id', '12121212');
        Util.Parameters parameters = new Util.Parameters('Account', inputMap);
        String whereQueryString = Util.constructWhereQuery(parameters);
    }
    @isTest
    public static void generalQuery_Test() {
        List<String> desiredFields = new List<String>{'Id'};
        Util.Parameters params = new Util.Parameters('Account', desiredFields);
        List<Account> accountList = (List<Account>) Util.generalQuery(params);
    }
}