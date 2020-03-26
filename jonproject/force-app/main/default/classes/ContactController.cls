public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [
            SELECT Id, Name, Title, Phone, Email
            FROM Contact
            WHERE Name != null
            WITH SECURITY_ENFORCED
            LIMIT 10
        ];
    }
    @AuraEnabled
    public static String saveFunction(List<Contact> contactList) {
        update contactList;
        String acrv = 'SUCCESS';
        return acrv;
    }
    @AuraEnabled
    public static String saveFunction(Map<String, String> contactIdToPhoneMap) {
        Set<Id> contactIdSet = [SELECT ID FROM Account]
        for (String looper : contactIdToPhoneMap.keySet()){
            contactIdSet.add((Id) looper);
        }
        String acrv = 'SUCCESS';
        return acrv;
    }
}