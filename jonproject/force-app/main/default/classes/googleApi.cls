public with sharing class googleApi {
    public googleApi() {

    }
    @AuraEnabled
    public static String callOut(){
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('callout:google_api_key'+'{!$Credential.Password}'+'&cx=017576662512468239146:omuauf_lfve&q=lectures');
        HttpResponse res = new Http().send(req);
        System.debug('RESPONSEN: '+res.getBody());
        String resString = (String) res.getBody();
        return resString;
    }
}
