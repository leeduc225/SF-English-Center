public class CaseCalloutHttp {
    public static HttpResponse postCallout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SF_eng_org/services/apexrest/v1/Cases');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"textCheck__c":"night"}');
        HttpResponse response = http.send(request);
		 // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
    
    public static HttpResponse getCallout(String caseNumber ) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SF_eng_org/services/apexrest/v1/Cases?caseNumber=' + caseNumber);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug(results);
        }
        return response;
    }
}