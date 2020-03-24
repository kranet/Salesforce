public with sharing class OpportunityController {
    public OpportunityController(){
    }
    
    @AuraEnabled
    public static String saveFunction(List<Opportunity> opportunityList) {
        for (Opportunity opportunity : opportunityList) {
            System.debug('Loop: '+opportunity.getSObjectType());
        }
        String acrv = 'SUCCESS';
        return acrv;
    }
}