@isTest
public with sharing class TestDataFactory {
    public TestDataFactory() {

    }
    public static Account createAccount(Integer amount){
        List<Account> accList = new List<Account>();
        Account returnAcc;
        for(Integer looper = 1; looper <= amount; looper++) {
            Account acc = new Account();
            acc.Name = 'TEST Account '+looper;
            acc.AccountNumber = '01189998819991197253'+looper;
            accList.add(acc);
            returnAcc = acc;
        }
        insert accList;
        return returnAcc;
    }
}
