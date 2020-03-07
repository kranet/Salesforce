import {LightningElement, api, wire} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {getRecord} from 'lightning/uiRecordApi';
import getContactList from '@salesforce/apex/ContactController.getContactList';

//const FIELDS = ['Opportunity.Name', 'Opportunity.StageName'];

export default class ConnectAccount extends LightningElement {
    @api recordId;

    objectName; 
    contacts;
    opportunity;
    
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredRecord({ error, data }) {
        console.log('hej1');

        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading opportunity',
                    message,
                    variant: 'error',
                }),
            );
        } else if (data) {
            console.log('hej2');
            console.log('Datan: '+data);
            this.opportunity = data;
            this.name = this.opportunity.fields.Name.value;
            this.StageName = this.opportunity.fields.StageName.value;
        }
    }
    handleClick() {
        console.log("Button Clicked!");
        console.log("recordId: "+recordId);
        console.log("jaha");
       }
       handleLoad() {
        getContactList()
            .then(result => {
                this.opportunities = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.opportunities = undefined;
            });
    }
}