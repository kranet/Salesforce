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
}