import { LightningElement,track,api } from 'lwc';
import feedbackTaken from '@salesforce/label/c.IsFeedbackTaken';
import retrieveUserDetails from '@salesforce/apex/QuizController.fetchUserDetails';
import fetchFeedbackRequired from '@salesforce/apex/QuizController.fetchFeedbackRequired';
import retrieveQuestionDetails from '@salesforce/apex/QuizController.retrieveQuestionDetails';
import retrievePerformanceMetrics from '@salesforce/apex/QuizController.retrievePerformanceMetrics';

export default class QuizMainComponent extends LightningElement {
    @track userName;
    @track userEmailId;
    @track isFeedbackAvailable=false;
    @track givenUserDetails;
    @track givenUserErrorDetails;
    @track isUserLoggedIn=false;
    @track givenUserScore;
    @track givenUserId;
    @track givenDynamicInput={};
    @track givenFeedbackSuccessResponse;
    @track givenFeedbackErrorResponse;
    @track showMessageFeedback=false;
    @track isTopicPresent=false;
    @track isBasic=false;
    @track isIntermediate=false;
    @track isAdvance=false;
    @track selectedTopicName;
    @track selectedTopicId;
    @track selectedQuestionDetailsSuccess;
    @track selectedQuestionDetailsError;
    @track isExamLevelSelected=false;
    @api apexAnswers=[];
    @track timeVal='0:0:0:0';
    @track visibleQuestion;
    @track selected={};
    @track showSubmit;
    @track countVisibleQuestion=0;
    @track strCorrectAnswers;
    @track showAllAnswers=false;
    @track countQuestion=0;
    @track performanceListSuccess;
    @track performanceListError;
    @api labelCollection;
    @api valueCollection;
    @api bgCollection=['rgb(60,179,113)','rgb(60,179,113)','rgb(255,165,0)','rgb(0,0,255)','rgb(255,0,0)'];
    @api chartUserName;
    @track showLookup=false;
    /*Feedback  present or not */
    @track label={feedbackTaken}; // To fetch in component - label.feedbackTaken
    connectedCallback(){
        let feedbackLabel=this.label.feedbackTaken;
        if(feedbackLabel=='Yes'){
            this.isFeedbackAvailable=false;
            //this.isFeedbackAvailable=false;
        }else if(feedbackLabel=='No'){
            this.isFeedbackAvailable=false;
        }else{
            this.isFeedbackAvailable=false;
        }
    }
    /*Construction of Questions in Feedback Starts*/
    myQuestions=[
        {
            id:"Question 1",
            question:"How did this course fit with your existing schedule?",
            answer:""
        },{
            id:"Question 2",
            question:"Did you used Flows before in your project ?",
            answer:""
        },{
            id:"Question 3",
            question:"How can we make the forthcoming sessions better?",
            answer:""
        },{
            id:"Question 4",
            question:"Do you feel the session is worth the time ?",
            answer:""
        },{
            id:"Question 5",
            question:"What topic in flow you like least?",
            answer:""
        },{
            id:"Question 6",
            question:"How do you rate these flow session?",
            answer:""
        },{
            id:"Question 7",
            question:"Which topics do you wish were more in-depth / had more follow-up?",
            answer:""
        },{
            id:"Question 8",
            question:"Do you feel prepared to use this information in a real-world situation?",
            answer:""
        }
    ];
    /*Construction of Questions in Feedback Ends */
    /*handleSubmit click */
    handleSubmitClick(event){
        /*For Fetching User Name and Email ::: Starts */
        var userInputs=this.template.querySelectorAll("lightning-input");
        userInputs.forEach(function(element) {
            if(element.name=="givenUserName")
                this.userName=element.value;
            else if(element.name=="givenUserEmail")
                this.userEmailId=element.value;
        },this);
        /*For Fetching User Name and Email ::: Ends */
        /*handle Apex class QuizController --> fetchUserDetails Method -Imperative Method*/
        retrieveUserDetails({
            strUserName:this.userName,
            strUserEmail:this.userEmailId
        })
        .then((result) => {
            this.givenUserDetails=result;
            this.givenUserErrorDetails=undefined;
            this.isUserLoggedIn=true;
            this.givenUserScore=result.strUserScore;
            this.givenUserId=result.strUserId;
            this.showLookup=true;
        })
        .catch((error) => {
            this.givenUserDetails=undefined;
            this.givenUserErrorDetails=error;
            this.isUserLoggedIn=true;
            this.showLookup=true;
        });
        
    }

    /*handleTextChange click */
    handleTextChange(event){
        /*Handling feedback details Starts*/
        const {name,value}=event.target;
        this.givenDynamicInput={...this.givenDynamicInput,[name]:value};
        /*Handling feedback details Ends */
    }

    /*handleFeedbackSubmit click */
    handleFeedbackSubmit(event){
        /*Handling apex class - fetchFeedbackRequired */
        fetchFeedbackRequired({
            strFeedbackComments:JSON.stringify(this.givenDynamicInput),
            strParticipantId:this.givenUserId
        })
        .then((result) => {
            this.givenFeedbackSuccessResponse=result;
            this.givenFeedbackErrorResponse=undefined;
            this.showMessageFeedback=true;
            this.isFeedbackAvailable=false;
            this.showLookup=true;
        })
        .catch((error) =>{
            this.givenFeedbackSuccessResponse=undefined;
            this.givenFeedbackErrorResponse=error;
            this.showMessageFeedback=true;
            this.isFeedbackAvailable=false;
            this.showLookup=true;
        });
    }

 
    /*handleFeedbackReset click */
    handleFeedbackReset(event){

    }

    /*Event on Lookup Component */
    handleTopicSelected(event){
        this.isTopicPresent=true;
        this.isBasic=event.detail.selectedBasic;
        this.isIntermediate=event.detail.selectedIntermediate;
        this.isAdvance=event.detail.selectedAdvance;
        this.selectedTopicName=event.detail.selectedTopicName;
        this.selectedTopicId=event.detail.selectedTopicId;
    }

    handleSelectTopic(event){
        let selectedExamLevel=event.target.dataset.buttonname;
        this.isExamLevelSelected=true;
        /*Handling Apex class- fetching questions Starts*/
        retrieveQuestionDetails({
            strTopicId:this.selectedTopicId,
            strExamLevelName:selectedExamLevel
        })
        .then((result) => {
            this.selectedQuestionDetailsSuccess=result;
            this.selectedQuestionDetailsError=undefined;
        })
        .catch((error) =>{
            this.selectedQuestionDetailsSuccess=undefined;
            this.selectedQuestionDetailsError=error;
        });
    }


    handleCheckboxSelect(event){
        const {name,value} =event.target;
        this.selected={...this.selected, [name]:value};
    }

    handleRadiobuttonSelect(event){
        const {name,value} =event.target;
        this.selected={...this.selected, [name]:value};
    }

    handleUpdateQuestionDetails(event){
        this.visibleQuestion=[...event.detail.records];
        this.countVisibleQuestion=this.countVisibleQuestion+1;
        if(this.countVisibleQuestion == this.selectedQuestionDetailsSuccess.length){
            this.showSubmit=true;
        }
    }

    
    handleSubmitAnswers(event){
        event.preventDefault();
        var labelCol=[];
        var valueCol=[];
        let correctCount=0;
        /*Taking the count of Answers  Ends*/
        for(var i=0; i<this.selectedQuestionDetailsSuccess.length;i++){
            if(this.selected[this.selectedQuestionDetailsSuccess[i].strQuestionId] === this.selectedQuestionDetailsSuccess[i].strCorrectAnswers){
                correctCount=correctCount+1;
            }
        }
        console.log('correctCount:::',correctCount);
        this.chartUserName=this.givenUserDetails.strUserName;
        //Calling apex class
        retrievePerformanceMetrics({
            strParticipantId:this.givenUserDetails.strUserId,
            strTopicId:this.selectedTopicId,
            decScore:correctCount
        })
        .then((result) => {
            this.performanceListSuccess=result;
            console.log('resultant score value:::',result);
            //Collecting labels and values collectively
            for(var i=0; i<result.length;i++){
                labelCol.push(result[i].strTopicName);
                valueCol.push(result[i].decScore);
            }
            console.log('labelCol::',labelCol);
            console.log('valueCol::',valueCol);
            this.performanceListError=undefined;
            this.labelCollection=labelCol;
            this.valueCollection=valueCol;
            console.log('labelCollection:::',this.labelCollection);
            console.log('valueCollection:::',this.valueCollection);
            this.countQuestion=correctCount;
            this.isUserLoggedIn=true;
            this.isTopicPresent=false;
            this.isExamLevelSelected=false;
            this.showSubmit=false;
            this.showAllAnswers=true;
        })
        .catch((error) =>{
            this.performanceListSuccess=undefined;
            this.performanceListError=error;
        });
        
    }

    get isScoredFull(){
        let showFilters=(this.selectedQuestionDetailsSuccess.length===this.countQuestion?'slds-text-color_success':'slds-text-color_error');
        return 'slds-text-heading_large '+showFilters;
    }
}