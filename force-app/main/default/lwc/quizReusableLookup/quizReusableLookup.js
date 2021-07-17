import { api, LightningElement, track, wire } from 'lwc';
import searchObject from '@salesforce/apex/QuizController.searchObject';

export default class QuizReusableLookup extends LightningElement {
    @api objName='Topic__c';
    @api iconName;
    @api filter='';
    @api searchPlaceholder='Search';
    @track selectedName;
    @track records;
    @track isValueSelected;
    @track blurTimeout;
    @track searchTerm;
    @track boxclass='slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    @track inputClass='';
    
    /*Making Apex class call  */
    @wire(searchObject, {strSearchTerm:'$searchTerm', strObject:'$objName', strFilterType:'$filter'})
    wiredRecords({ error, data }){
        if(data){
            console.log('data inside:::',data);
            this.error=undefined;
            this.records=data;
        } else if(error){
            this.error=error;
            this.records=undefined;
        }
    }

    /*handleClick method */
    handleClick(){
        this.searchTerm='';
        this.inputClass='slds-has-focus';
        this.boxclass='slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus slds-is-open';
    }

    onBlur(){
        this.blurTimeout=setTimeout(
            ()=>{
                this.boxclass='slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus'
            },300 
        );
    }

    onSelect(event){
        let selectedId=event.currentTarget.dataset.id;
        let selectedName=event.currentTarget.dataset.name;
        let isBasic=event.currentTarget.dataset.basic;
        let isIntermediate=event.currentTarget.dataset.intermediate;
        let isAdvance=event.currentTarget.dataset.advance;
        //Event call
        console.log('selectedId::::',selectedId);
        let selectedValues={selectedTopicId:selectedId, 
                            selectedTopicName:selectedName,
                            selectedBasic:isBasic,
                            selectedIntermediate:isIntermediate,
                            selectedAdvance:isAdvance
                        };
        console.log('selectedValues::::',selectedValues);
        const valueSelectedEvent= new CustomEvent('lookupselected', {detail: selectedValues});
        this.dispatchEvent(valueSelectedEvent);
        this.isValueSelected=true;
        this.selectedName=selectedName;
        if(this.blurTimeout){
            clearTimeout(this.blurTimeout);
        }
        this.boxclass='slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    }

    handleRemovePill(){
        this.isValueSelected=false;
    }

    onChange(event){
        this.searchTerm=event.target.value;
    }


}