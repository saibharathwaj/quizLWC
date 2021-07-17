public class SceTest {
    public static HttpResponse getStateWiseSeriesAPI(){
    HttpResponse httpResponse;
    String endPoint='https://api.covid19india.org/state_district_wise.json';
    try {
        Http http= new Http();
        HttpRequest httpRequest= new HttpRequest();
        httpRequest.setHeader('Content-Type', 'application/json');
        httpRequest.setMethod('GET');
        httpRequest.setEndPoint(endPoint);
        httpRequest.setTimeout(1300);
        httpResponse= http.send(httpRequest);
        System.debug('HttpResponse for getNationalWideSeries::::'+httpResponse);
        System.debug('getNationalWideSeries - HttpResponse.getBody::::'+httpResponse.getBody());
    }catch(Exception e){
        System.debug('Exception in getNatiionalWideSeries:::::'+e.getLineNumber()+'~~ message:::'+e.getMessage());
    }
    return httpResponse;
}
    
    public static void checkStatewise(){
        HttpResponse httpResponse= SceTest.getStateWiseSeriesAPI();
        if(httpResponse.getStatusCode() == 200){
            String jsonString= httpResponse.getBody();
            
        }
    }

}