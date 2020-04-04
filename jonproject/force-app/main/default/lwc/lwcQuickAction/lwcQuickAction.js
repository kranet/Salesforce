import { LightningElement, api} from 'lwc';
import { publish, createMessageContext,releaseMessageContext, subscribe, unsubscribe } from 'lightning/messageService';
import messageChannelShowcase from "@salesforce/messageChannel/messageChannelShowcase__c";
export default class LwcQuickAction extends LightningElement {
    @api recordId;

    context = createMessageContext();


    renderedCallback() {
        this.messageBack();
    }
    messageBack(){
        const message = {
            loading: false
        };
        publish(this.context, messageChannelShowcase, message);
    }
}