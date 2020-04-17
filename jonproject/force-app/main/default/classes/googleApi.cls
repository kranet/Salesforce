public with sharing class googleApi {
    public googleApi() {

    }
    @AuraEnabled
    public static String callOut(){
       /*  HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('callout:google_api_key');
        req.setHeader('APIKEY', '{!$Credential.Password}');
        HttpResponse res = new Http().send(req);
        return JSON.stringify(res); */
        return '';
    }
}
