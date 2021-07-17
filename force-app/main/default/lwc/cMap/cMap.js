import { LightningElement, track,wire } from 'lwc';
import getStatesData from '@salesforce/apex/CoronaStateWiseApex.getStatesData';
export default class CMap extends LightningElement {
     @track mapMarkers=[];
    @track error;
    @track results;
    @wire(getStatesData) results;

    connectedCallback(){
        console.log('res:::', this.results);
    }
}