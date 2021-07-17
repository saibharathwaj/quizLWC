import { LightningElement, track } from 'lwc';
import USER_ID from '@salesforce/user/Id';
import USER_NAME from '@salesforce/schema/User.Name';

export default class Selector extends LightningElement {
    @track name;
    @track userId;
    selectedProductId;
    name=USER_NAME;
    userId=USER_ID;
    handleProductSelected(evt) {
        this.selectedProductId = evt.detail;
    }
}