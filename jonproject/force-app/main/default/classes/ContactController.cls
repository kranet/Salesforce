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
        for (Contact contact : contactList) {
            System.debug('Loop: '+contact.getSObjectType());
        }
        String acrv = 'SUCCESS';
        return acrv;
    }
}