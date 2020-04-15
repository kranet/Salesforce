import { LightningElement } from 'lwc';
import callOut from '@salesforce/apex/googleApi.callOut';

export default class GoogleSearchSample extends LightningElement {
    connectedCallback() {
        this.init();
    }
    init = async () => {
        try {
            let response = await callOut();
            console.log('RESONS I JS: '+response);
        } catch (error) {
            this.error = error;
        }
    }
}