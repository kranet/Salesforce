public with sharing class Util {
    public static List<SObject> generalQuery (Parameters parameters) {
        String modularQueryString = constructFirstPartQuery(parameters);
        if (parameters.fieldNameToValueMap.size() > 0) {
            modularQueryString += constructWhereQuery(parameters);
        }
        return (List<SObject>)Database.query(modularQueryString);
    }
    
    public with sharing class Parameters {
        String sObjectType;
        String whereOperator;
        Map <String, String> fieldNameToValueMap = new Map<String, String>();
        List<String> fields;

        public parameters(String sObjectType, List<String> desiredFields) {
            this.sObjectType = sObjectType;
            this.fields = desiredFields;
        }
        public parameters(String sObjectType, Map<String, String> desiredFieldsToValuesMap) {
            this.sObjectType = sObjectType;
            this.fieldNameToValueMap = desiredFieldsToValuesMap;
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

        List<String> selectTheseFields;
        if (parameters.fields.size() > 0){
            selectTheseFields = parameters.fields;
        } else if (parameters.fieldNameToValueMap.size() > 0) {
            selectTheseFields.addAll(parameters.fieldNameToValueMap.keySet());
            System.debug('selected fields: '+selectTheseFields);
        }
        Integer loopCount = 1;
        Integer maxLoopCount = parameters.fields.size();

        for(String field : selectTheseFields) {
            query += field;
            if(loopCount != maxLoopCount) {
                query += ', ';
            }
            loopcount++;
        }
        query += ' FROM ' +parameters.sObjectType;
        return query;
    }
}