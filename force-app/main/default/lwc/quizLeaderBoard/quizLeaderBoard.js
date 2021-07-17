import { LightningElement, track } from 'lwc';
import STYLE_CSS from '@salesforce/resourceUrl/StyleCSS'; 
import retrieveTopPerformer from '@salesforce/apex/QuizController.getParticipants';

export default class QuizLeaderBoard extends LightningElement {
    @track perfSuccess;
    @track perfError;
    connectedCallback(){
        this.topPerformers();
    }

    topPerformers(){
        retrieveTopPerformer({})
        .then((result) => {
            this.perfSuccess=result;
            this.perfError=undefined;
        })
        .catch((error) =>{
            this.perfError=error;
            this.perfSuccess=undefined;
        })
    }
}