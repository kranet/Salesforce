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
    public static String saveFunction(String StringifiedContactIdToPhoneObject) {
        try {
            Map<String, String> contactIdToPhoneMap = (Map<String, String>) JSON.deserialize(StringifiedContactIdToPhoneObject, Map<String, String>.class);
            Set<Id> contactIdsToUpdateSet = Util.convertSet(contactIdToPhoneMap.keySet());
            List<Contact> contactsToUpdate = GenericSObjectSelector.newInstance(Contact.sObjectType).selectByIds(contactIdsToUpdateSet);
            for (Contact c : contactsToUpdate){
                c.Phone = '';
            }
            update contactsToUpdate;
            String acrv = 'SUCCESS';
            return acrv;
        }
        catch (Exception e) {
            System.debug('Saving failed with error: ' +e.getMessage());
            return 'ERROR';
        }
    }
}