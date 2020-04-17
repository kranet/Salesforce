import { LightningElement } from 'lwc';
import callOut from '@salesforce/apex/googleApi.callOut';

export default class GoogleSearchSample extends LightningElement {
  /*   connectedCallback() {
        this.init();
        function initMap() {
            // The location of Uluru
            var uluru = {lat: -25.344, lng: 131.036};
            // The map, centered at Uluru
            var map = new google.maps.Map(
                document.getElementById('map'), {zoom: 4, center: uluru});
            // The marker, positioned at Uluru
            var marker = new google.maps.Marker({position: uluru, map: map});
          }
    }
    init = async () => {
        try {
            let response = await callOut();
            console.log('RESPONS I JS: '+response);
        } catch (error) {
            this.error = error;
        }
    }
    jsCallOut = async () => {
            src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap">;
    } */
    
}