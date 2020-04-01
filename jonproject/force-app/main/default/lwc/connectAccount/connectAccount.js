import {LightningElement, api, wire} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {getRecord} from 'lightning/uiRecordApi';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import saveFunction from '@salesforce/apex/ContactController.saveFunction';

const FIELDS = ['Opportunity.Name', 'Opportunity.StageName'];

export default class ConnectAccount extends LightningElement {
    @api recordId;
    @api record;

    objectName; 
    contacts;
    opportunity;
    opportunities;
    contactIdToPhoneMap = new Map();
    
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
        console.log("recordId: "+recordId);
        console.log("jaha");
       }
    handleCheckboxClick(event) {
        let triggeringContactId = event.target.dataset.contactid;
        let triggeringContactPhone = event.target.dataset.contactphone;
        switch (event.target.checked) {
            case false: {
                console.log('Reseting map');
                if (this.contactIdToPhoneMap.get(triggeringContactId)) this.contactIdToPhoneMap.delete(triggeringContactId);
            }
            case true: {
                console.log('Building map');
                this.contactIdToPhoneMap.set(triggeringContactId, triggeringContactPhone);
            }
        }
        console.log('map1: '+this.contactIdToPhoneMap.get(triggeringContactId));
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
        this.contactIdToPhoneMap.forEach((value, key) => {
            console.log('Checking values: '+value);
        })
        let toApexObject = this.translateMapToObject(this.contactIdToPhoneMap);
        let toApexObjectStringified = JSON.stringify(toApexObject);
        console.log('Stringified: '+toApexObjectStringified);
        saveFunction({StringifiedContactIdToPhoneObject: toApexObjectStringified})
            .then((result) => {
                console.log('Saved: '+result);
            })
    }
    translateMapToObject(map){
         console.log('Translating map!');
         let obj = Array.from(map).reduce((obj, [key, value]) => {
            obj[key] = value;
            return obj;
          }, {});
          console.log('Objektet: '+obj);
        return obj;
    }
}