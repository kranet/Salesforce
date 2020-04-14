import { LightningElement, api, wire} from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import { publish, subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import messageChannelShowcase from '@salesforce/messageChannel/messageChannelShowcase__c';

export default class LwcQuickAction extends LightningElement {
    @api recordId;
    @wire(MessageContext)
    messageContext;
    contacts;
    subscription = null;

    allowProceed = true;
    
    //First method run
    connectedCallback() {
        this.getContactList();
    }
    //Second method run
    renderedCallback() {
        this.messageBack();
        this.setSubscribtion();
    }


    //Structured helper methods
    messageBack(){
        const message = {
            loading: false
        };
        publish(this.messageContext, messageChannelShowcase, message);
    }
    handleMessage(message){
        this.receivedMessage = message ? JSON.stringify(message, null, '\t') : 'no message payload';
        if(message.error !== undefined && message.error !== null){
            this.allowProceed = message.error;
        }
    }
    setSubscribtion(){
        if (this.subscription) {
            return;
        }
        this.subscription = subscribe(this.messageContext, messageChannelShowcase, (message) => {
            this.handleMessage(message);
        }, {scope: APPLICATION_SCOPE});
    }
    
    getContactList() {
        getContactList()
            .then(result => {
                this.contacts = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.contacts = undefined;
            });
    }
    handleCancelClick(event){
        console.log('LWC CANCEL STATE');
            if(confirm('Discard your changes?')) {
                const unloadauraevent = new CustomEvent("unloadauraevent", {
                    detail: 1
                  });
                this.dispatchEvent(unloadauraevent);
            } else {
              event.preventDefault();
            }
    }
}