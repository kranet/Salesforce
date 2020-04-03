public with sharing class Util {
    public static Set<Id> convertSet(Set<String> inputSet) {
        Set<Id> idSet = (Set<Id>)JSON.deserialize(JSON.serialize(inputSet), Set<Id>.class);
        return idSet;
    }
    public static Set<String> convertSet(Set<Id> inputSet) {
        Set<String> stringSet = (Set<String>)JSON.deserialize(JSON.serialize(inputSet), Set<String>.class);
        return stringSet;
    }
    public static Set<Id> setifyList(List<Account> inputList) {
        Set<Id> ids = (new Map<Id,Account>(inputList)).keySet();
        return ids;
    }
}