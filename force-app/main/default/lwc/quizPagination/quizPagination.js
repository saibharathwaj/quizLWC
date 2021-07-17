import { LightningElement,api, track } from 'lwc';

export default class QuizPagination extends LightningElement {
    @track showSubmitButton;
    currentPage=1;
    totalPageRecords;
    recordSize=1;
    visibleRecords;
    totalPage;
    get totalRecords(){
        return this.visibleRecords;
    }
    @api 
    set totalRecords(data){
        if(data){
            this.totalPageRecords=data;
            this.totalPage=Math.ceil(data.length/this.recordSize);
            this.updateRecords();
        }
    }
    handlePrevious(event){
        if(this.currentPage > 1){
            this.currentPage=this.currentPage-1;
            this.updateRecords();
        }
    }

    handleNext(event){
        if(this.currentPage < this.totalPage){
            this.currentPage=this.currentPage+1;
            this.updateRecords();
        }
    }

    get disablePrevious(){
        this.showSubmitButton=false;
        return this.currentPage <=1;
    }

    get disableNext(){
        this.showSubmitButton=true;
        return this.currentPage>=this.totalPage;
    }

    updateRecords(){
        const start=(this.currentPage-1)*this.recordSize;
        const end=this.recordSize*this.currentPage;
        this.visibleRecords=this.totalPageRecords.slice(start, end);
        this.dispatchEvent(new CustomEvent('update', {
            detail:{
                records:this.visibleRecords
            }
        }));
    }
}