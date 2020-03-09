public with sharing class OpportunityController {
    public OpportunityController(){
    }
    
    @AuraEnabled
    public static String saveFunction(List<Opportunity> opportunityList) {
        String acrv = 'SUCCESS';
        return acrv;
    }
}