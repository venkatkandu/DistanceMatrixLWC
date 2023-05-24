public class DistanceMatrixAPIHelper {
    public static DistanceMatrixResponse callDistanceMatrixAPI(String sourceAddress, String destinationAddress, String travelMode) {
        // Construct the API endpoint URL
        String apiUrl = 'https://maps.googleapis.com/maps/api/distancematrix/json';
        string apiKey= 'AIzaSyBcjIyzIugBGpokRKQhVFh5HIbmNNnzzNA';
        
        // Construct the request URL with required parameters
        String requestUrl = apiUrl + '?origins=' + EncodingUtil.urlEncode(sourceAddress, 'UTF-8') +
        '&destinations=' + EncodingUtil.urlEncode(destinationAddress, 'UTF-8') +
        '&mode=' + EncodingUtil.urlEncode(travelMode, 'UTF-8') +
        '&key=' + apiKey;
        
        // Create an instance of the HTTP Class
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        // Set the HTTP method and endpoint URL
        request.setMethod('GET');
        request.setEndpoint(requestUrl);
        
        try {
            // Make the API call
            HttpResponse response = http.send(request);
            
            // Process the API response
            if (response.getStatusCode() == 200) {
                // API call successful
                DistanceMatrixResponse distanceMatrixResponse = (DistanceMatrixResponse)JSON.deserialize(response.getBody(), DistanceMatrixResponse.class);
                return distanceMatrixResponse;
            } else {
                throw new AuraHandledException('Distance Matrix API Call failed with status code: ' + response.getStatusCode());
            }
        } catch (Exception ex) {
            // Exception occurred during the API call
            throw new AuraHandledException('Exception occurred during API call: ' + ex.getMessage());
        }
    }
}