@RestResource(urlMapping='/v1/Cases/*')
global class CaseAPI {
    // @HttpGet
    // global static Case doGet() {
    //     RestRequest req = RestContext.request;
    //     String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
    //     Case result = [SELECT Id, CaseNumber, ContactEmail, TextCheck__c, Status FROM Case WHERE Id = :caseId];
    //     return result;
    // }

    @HttpGet
    global static Case doGetCaseNumber() {
        RestRequest req = RestContext.request;
        String caseNumber = req.params.get('caseNumber');
        Case result = [SELECT Id, CaseNumber, ContactEmail, TextCheck__c, Status FROM Case WHERE CaseNumber = :caseNumber];
        return result;
    }

    @HttpPost
    global static Case doPost() {
        RestRequest req = RestContext.request;
        Map<String,Object> params = (Map<String,Object>) JSON.deserializeUntyped(req.requestBody.toString());
        Case cs = new Case();
        for (String field : params.keySet()) {
            cs.put(field, params.get(field));
        }
        insert cs;
        Case result = [SELECT Id, CaseNumber, ContactEmail, TextCheck__c, Status FROM Case WHERE Id = :cs.Id];
        return result;
    }

    @HttpPatch
    global static Case doPatch() {
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Case cs = [SELECT Id, CaseNumber, ContactEmail, TextCheck__c, Status FROM Case WHERE Id = :caseId];
        Map<String,Object> params = (Map<String,Object>) JSON.deserializeUntyped(req.requestBody.toString());
        for (String field : params.keySet()) {
            cs.put(field, params.get(field));
        }
        update cs;
        Case result = [SELECT Id, CaseNumber, ContactEmail, TextCheck__c, Status FROM Case WHERE Id = :cs.Id];
        return result;
    }

    @HttpPut
    global static Case doPut() {
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Case cs = new Case();
        cs.Id = caseId;
        Map<String,Object> params = (Map<String,Object>) JSON.deserializeUntyped(req.requestBody.toString());
        for (String field : params.keySet()) {
            cs.put(field, params.get(field));
        }
        upsert cs;
        return cs;
    }

	@HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Case cs = [SELECT Id FROM Case WHERE Id = :caseId];
        delete cs;
    }
}