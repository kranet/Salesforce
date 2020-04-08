import { LightningElement, api} from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
export default class LwcQuickAction extends LightningElement {
    @api recordId;
    contacts;

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