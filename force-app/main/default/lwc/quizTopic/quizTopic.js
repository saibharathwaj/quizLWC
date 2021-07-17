import { LightningElement,track,api,wire } from 'lwc';
import retrieveTopic from '@salesforce/apex/QuizController.retrieveTopic';
import { refreshApex } from '@salesforce/apex';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';
const columns=[
    {
        label:'Topic Name',
        fieldName:'Topic_Name__c',
        type:'text',
        sortable:true
    }
];

export default class QuizTopic extends LightningElement {
    
    @track data=[];
    @track items=[];
    @track columns;
    @track startingRecord=1;
    @track endingRecord=0;
    @track pageSize=5; 
    @api sortedDirection='asc';
    @api sortedBy='Name';
    result;
    @track page=1;
    @track totalRecountCount=0;
    @track totalPage=0;
    @track error;
    @wire(CurrentPageReference) pageRef;
    connectedCallback(){
        retrieveTopic({})
        .then((data) =>{
            this.items=data;
            this.totalRecountCount=data.length;
            this.totalPage=Math.ceil(this.totalRecountCount/this.pageSize);
            this.data=this.items.slice(0,this.pageSize);
            this.endingRecord=this.pageSize;
            this.columns=columns;
            this.error=undefined;
        })
        .catch((error)=>{
            this.error=error;
            this.data=undefined;
        })
    }

    previousHandler(){
        if(this.page > 1){
            this.page=this.page-1;
            this.displayRecordPerPage(this.page);
        }
    }

    nextHandler(){
        if((this.page<this.totalPage) && this.page!==this.totalPage){
            this.page=this.page+1;
            this.displayRecordPerPage(this.page);
        }
    }

    displayRecordPerPage(page){
        this.startingRecord=((page - 1)*this.pageSize);
        this.endingRecord=(this.pageSize*page);
        this.endingRecord=(this.endingRecord > this.totalRecountCount) ? this.totalRecountCount :this.endingRecord;
        this.data=this.items.slice(this.startingRecord, this.endingRecord);
        this.startingRecord=this.startingRecord+1;
    }

    sortColumns(event){
        this.sortedBy=event.detail.fieldName;
        this.sortedDirection=event.detail.sortedDirection;
        return refreshApex(this.result);
    }

    getSelectedName=event=>{
        var selectedRows=event.detail.selectedRows;
        if(selectedRows.length>1){
            var el=this.template.querySelector('lightning-datatable');
            selectedRows=el.selectedRows=el.selectedRows.slice(1);
            this.showNotification();
            event.preventDefault();
            return;
        }else{
            for(var i=0; i<selectedRows.length; i++){
                //alert('You selected::::'+selectedRows[i].Topic_Name__c);
                console.log('Selected Topic Id:::',selectedRows[i].Id);
                fireEvent(this.pageRef,"selectedTopics", selectedRows[i]);
                console.log('Fired::');
            }
        }
    }

    showNotification(){
        const event= new ShowToastEvent({
            title:'Error',
            message:'Only one row can be selected',
            variant:'warning',
            mode:'pester'
        });
        this.dispatchEvent(event);
    }
    
    
}