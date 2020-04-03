import {LightningElement, api, wire} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

const FIELDS = ['Opportunity.Name', 'Opportunity.StageName'];

export default class ConnectAccount extends LightningElement {
    @api objectListStringified;
    
    accountList = [];
    connectedCallback() {
        JSON.parse(this.objectListStringified).forEach(object =>{
            this.accountList.push(object);
        });
        console.log(this.accountList.size);
    }
}