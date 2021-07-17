import { LightningElement } from 'lwc';

export default class HelloConditionalRendering extends LightningElement {
    isVisible=false;

    handleClick(event){
        this.isVisible=true;
    }
}