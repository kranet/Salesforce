import { LightningElement, api} from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import { publish, createMessageContext,releaseMessageContext, subscribe, unsubscribe } from 'lightning/messageService';
import messageChannelShowcase from '@salesforce/messageChannel/messageChannelShowcase__c';

export default class LwcQuickAction extends LightningElement {
    @api recordId;
    contacts;

    context = createMessageContext();
    //First method run
    connectedCallback() {
        this.getContactList();

    }
    //Second method run
    renderedCallback() {
        this.messageBack();
    }
    //Structured helper methods
    messageBack(){
        const message = {
            loading: false
        };
        publish(this.context, messageChannelShowcase, message);
    }
    getContactList() {
        getContactList()
            .then(result => {
                this.contacts = result;
                this.error = undefined;
                console.log('Result: '+contacts);
            })
            .catch(error => {
                this.error = error;
                this.contacts = undefined;
            });
    }
}