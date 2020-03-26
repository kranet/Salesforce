import {LightningElement, api, wire} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {getRecord} from 'lightning/uiRecordApi';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import saveFunction from '@salesforce/apex/ContactController.saveFunction';
import generalQuery from '@salesforce/apex/Util.generalQuery';

const FIELDS = ['Opportunity.Name', 'Opportunity.StageName'];

export default class ConnectAccount extends LightningElement {
    @api recordId;
    @api record;

    objectName; 
    contacts;
    opportunity;
    opportunities;
    contactIdToPhoneMap = {};
    
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })

    wiredRecord({ error, data }) {
        console.log('wiredRecordmetod');

        if (error) {
            console.log('error in wire');
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
            console.log('Found data from wire.');
            console.log('Data: '+data);
            this.opportunity = data;
            this.name = this.opportunity.fields.Name.value;
            console.log('Name: '+this.name);
            this.StageName = this.opportunity.fields.StageName.value;
        }
    }

    handleClick() {
        console.log("Button Clicked!");
        console.log("recordId: "+recordId);
        console.log("jaha");
       }
    handleCheckboxClick(event) {
        let triggeringContactId = event.target.dataset.contactid;
        let triggeringContactPhone = event.target.dataset.contactPhone;

        if(contactIdToPhoneMap.has(triggeringContactId)) {
            this.contactIdToPhoneMap.delete(triggeringContactId);
        } else {
            this.contactIdToPhoneMap.set(triggeringContactId, triggeringContactPhone);
        }
        console.log(event.target.dataset.contactid);
        console.log(event.target.dataset.contactphone);
        console.log(this.contactIdToPhoneMap(triggeringContactId, triggeringContactPhone));
        
        
       }

    handleLoad() {
        getContactList()
            .then(result => {
                console.log('Result: '+result);
                this.contacts = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.contacts = undefined;
            });
    }
    headerCheckoxChanged(event) {
        this.lineItemData.forEach(element =>{
            element.includedInAutomatedSupplies = event.target.checked;
        });
        console.log(JSON.stringify(this.lineItemData));
    }
    saveFunction() {
        saveFunction({contactList: this.contacts})
            .then((result) => {
                console.log('Saved: '+result);
            })
    }
}