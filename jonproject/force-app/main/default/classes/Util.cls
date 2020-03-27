public with sharing class Util {
    public static List<SObject> generalQuery (Parameters parameters) {
        String modularQueryString = constructFirstPartQuery(parameters);
        modularQueryString += constructSecondPartQuery(parameters);
        System.debug('Final non-set query: '+modularQueryString);
        return makeQuery(modularQueryString, parameters);
    }
    
    public static List<SObject> makeQuery(String modularQueryString, Parameters parameters) {
        if(parameters.soqlDirector == 'SET OF IDS'){
            return Database.query(modularQueryString +' WHERE Id IN '+ parameters.idSet);
        } else {
            return Database.query(modularQueryString);
        }
    }
   
    public static String constructWhereQuery(Parameters parameters){
        Map<String, String> fieldNameToValueMap = parameters.fieldNameToValueMap;
        if (fieldNameToValueMap.size() == 0) return '';

        String whereQuery = ' WHERE ';
        Integer loopCount = 1;
        Integer maxLoopCount = fieldNameToValueMap.size();

        for(String field : fieldNameToValueMap.keySet()) {
            whereQuery += field +' = ' + '\'' + fieldNameToValueMap.get(field) +'\'';
            if(loopCount != maxLoopCount) {
                if(parameters.whereOperator == 'AND'){
                    whereQuery += ' AND ';
                } else if (parameters.whereOperator == 'OR') {
                    whereQuery += ' OR ';
                } else whereQuery += ' AND ';
            }
            loopCount++;
        }
        System.debug(whereQuery);
        return whereQuery;
    }
    public static String constructFirstPartQuery(Parameters parameters){
        String query = 'SELECT ';

        List<String> selectTheseFields = new List<String>();
        switch on parameters.soqlDirector {
            when 'SIMPLE FIELDS' {
                selectTheseFields = parameters.fields;
            }
            when 'SPECIFIC FIELD VALUES' {
                System.debug('Map1: '+parameters.fieldNameToValueMap.keySet());
                Set<String> fieldSetHelper = (parameters.fieldNameToValueMap.keySet());
                selectTheseFields.addAll(fieldSetHelper);
                System.debug('After');
                System.debug(selectTheseFields);
            }
            when 'SET OF IDS' {
                selectTheseFields.add('Id');
            }
        }
        for(String field : selectTheseFields) {
            query += field;
            query += ',';
        }
        query = query.removeEnd(',');
        query += ' FROM ' +parameters.sObjectType;
        return query;
    }
    public static String constructSecondPartQuery(Parameters parameters){
        String secondPartQuery = '';
        switch on parameters.soqlDirector {
            when 'SPECIFIC FIELD VALUES'{
                secondPartQuery += constructWhereQuery(parameters);
            }
        }
        return secondPartQuery;
    }
    public static List<String> getAllFieldsOnObject(String sObjectType) {
        List<String> allFieldsOnObject;
        if(!String.isBlank(sObjectType)) {
            List<Schema.DescribeSObjectResult> objDesc = Schema.describeSObjects(new List<String>{sObjectType});
            Map<String, Schema.SObjectField> objFields = objDesc[0].fields.getMap();
            List<String> convertSetToListHelper = new List<String>(objFields.keySet());
            allFieldsOnObject = convertSetToListHelper;
        }
        return allFieldsOnObject;
    }
    public with sharing class Parameters {
        String sObjectType;
        String whereOperator;
        Map <String, String> fieldNameToValueMap = new Map<String, String>();
        List<String> fields;
        Set<Id> idSet;
        String soqlDirector;

        public parameters(String sObjectType, List<String> desiredFields) {
            this.sObjectType = sObjectType;
            this.fields = desiredFields;
            this.soqlDirector = 'SIMPLE FIELDS';
        }
        public parameters(String sObjectType, Map<String, String> desiredFieldsToValuesMap) {
            this.sObjectType = sObjectType;
            this.fields = Util.getAllFieldsOnObject(sObjectType);
            this.fieldNameToValueMap = desiredFieldsToValuesMap;
            this.soqlDirector = 'SPECIFIC FIELD VALUES';
        }
        public parameters(String sObjectType, List<String> desiredFields, Map<String, String> desiredFieldsToValuesMap) {
            this.sObjectType = sObjectType;
            this.fields = desiredFields;
            this.fieldNameToValueMap = desiredFieldsToValuesMap;
            this.soqlDirector = 'SPECIFIC FIELD VALUES';
        }
        public parameters(String sObjectType, Set<Id> idSet) {
            this.sObjectType = sObjectType;
            this.fields = Util.getAllFieldsOnObject(sObjectType);
            this.idSet = idSet;
            this.soqlDirector = 'SET OF IDS';
        }
        public parameters(String sObjectType, List<String> desiredFields, Set<Id> idSet) {
            this.sObjectType = sObjectType;
            this.fields = desiredFields;
            this.idSet = idSet;
            this.soqlDirector = 'SET OF IDS';
        }
    }
}