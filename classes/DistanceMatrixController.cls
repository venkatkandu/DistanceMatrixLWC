public with sharing class DistanceMatrixController {
    public DistanceMatrixController() {

    }
    @AuraEnabled(cacheable=true)
    public static String calculateDistance(String sourceAddress, String destinationAddress, string travelMode) {
        String duration = '-1';
        try {
            DistanceMatrixResponse response = DistanceMatrixAPIHelper.callDistanceMatrixAPI(sourceAddress,destinationAddress, travelMode);
            if(response != null){
                duration = response.rows[0].elements[0].duration.toString();                
            }
        }
        catch(Exception ex) {
            System.debug('Exception occured in calling callDistanceMatrix API' + ex.getMessage());
        }
        return duration;
    }
}