import { LightningElement, track } from 'lwc';
import calculateDistance from '@salesforce/apex/DistanceMatrixController.calculateDistance';

export default class DistanceMatrixComponent extends LightningElement {
    @track sourceAddress;
    @track destinationAddress;
    @track duration;
    @track isResultValid = false;
    @track isErrorOccured = false;
    errorMessage = '';
    @track travelModes = [
        { label: 'Driving', value: 'driving' },
        { label: 'Walking', value: 'walking' },
        { label: 'Transit', value: 'transit' },
        { label: 'Bicycling', value: 'bicycling' }
    ];
    @track selectedTravelMode;

    handleSourceAddressChange(event) {
        this.sourceAddress = event.target.value;
    }

    handleDestinationAddressChange(event) {
        this.destinationAddress = event.target.value;
    }

    handleTravelModeChange(event) {
        this.selectedTravelMode = event.target.value;
    }

    calculateDistance() {
        calculateDistance({ 
            sourceAddress: this.sourceAddress, 
            destinationAddress: this.destinationAddress,
            travelMode: this.selectedTravelMode
        })
        .then(result => {
            this.duration = result;
            this.isResultValid = this.duration != -1;
            if(!this.isResultValid) {
                this.isErrorOccured = true;
                this.errorMessage = 'Unable to calculate the distance';
            } else {
                this.isErrorOccured = false;
                this.errorMessage = '';
            }
            // Process the API response
            console.log('Distance Matrix API Response: ', result);
            // Handle the response as needed
        })
        .catch(error => {
            // Handle any errors
            console.error('Error calling Distance Matrix API: ', error);
        });
    }
}