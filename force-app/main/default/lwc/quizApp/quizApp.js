import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {
    selected={}; // for storing answers 
    correctAnswers=0; //Storing the count of Correct Answers.
    isSubmitted=false;
    get isScoredFull(){
        let showFilters=(this.myQuestions.length === this.correctAnswers? 'slds-text-color_success':'slds-text-color_error');
        return 'slds-text-heading_large '+showFilters;
    }
    get allNotSelected(){
        return !(Object.keys(this.selected).length === this.myQuestions.length);
    }
    myQuestions=[
        {
            id:"Question1",
            question:"Which one of the following is not a template Loop ?",
            answers:{
                a:"for:each",
                b:"iterator",
                c:"map loop"
            },
            correctAnswer:"c"
        },
        {
            id:"Question2",
            question:"Which of the file is invalid in LWC component folder?",
            answers:{
                a:".svg",
                b:".apex",
                c:".js"
            },
            correctAnswer:"b"
        },
        {
            id:"Question3",
            question:"Which one of the following is not a directive ?",
            answers:{
                a:"if:false",
                b:"if:true",
                c:"@track"
            },
            correctAnswer:"c"
        }
    ];

    changeHandler(event){
        /*const name=event.target.name;
        const value=event.target.value;
            -- instead of writing in two lines we can do in single line
        */
       const {name,value} =event.target;
       this.selected={...this.selected, [name]:value};
       console.log('selected::::', this.selected);
      // this.allNotSelected=false;
    }

    handleSubmit(event){
        event.preventDefault();
        /*
            this.selected ={"Question1":"a", "Question2":"b", "Question3":"c"};
            item contains myQuestion details
            check the correct answer matched with selected answer
        */
        let correct=this.myQuestions.filter(item=>this.selected[item.id] === item.correctAnswer);
        this.correctAnswers=correct.length;
        this.isSubmitted=true;
        console.log('correct::::',correct);
        console.log('correct answers::',this.correctAnswers);
    }

    handleReset(event){
        this.correctAnswers=0;
        this.selected={};
        this.isSubmitted=false;
    }
}