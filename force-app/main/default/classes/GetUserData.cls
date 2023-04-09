public class GetUserData {
    public static void getUserDataAPI() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            List<UserData> results = (List<UserData>) JSON.Deserialize(response.getBody(), List<UserData>.class);
            System.debug(results);
        }
    }
}