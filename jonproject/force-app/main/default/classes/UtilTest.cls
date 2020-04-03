@isTest
public with sharing class UtilTest {
    @testSetup 
    static void setup() {
        TestDataFactory.createAccount(3);
    }
}