import { LightningElement,wire, track, api } from 'lwc';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
import retrieveTopPerformerWrapper from '@salesforce/apex/QuizController.retrieveTopPerformerWrapper';
import chartResource from '@salesforce/resourceUrl/charts';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class QuizSelectedTopicsPerformance extends LightningElement {
    @api showPerf=false;
    chart;
    @track selectedDetails;
    @wire(CurrentPageReference) pageRef;
    retrievedTopicSuccess=[];
    retrieveTopicError;
    @api chartbgColor=['green','red','blue','pink','black'];
    @api chartjsInitialized = false;
    @track maxMarks;
    @track minMarks;
    @api selectedTopicName;
    connectedCallback(){
        registerListener("selectedTopics",this.selectTopicDetails,this);
    }

    disconnectedCallback(){
        unregisterAllListeners(this);
    }

    renderedCallback(){
        if (this.chartjsInitialized) {
            return;
        }
        this.chartjsInitialized = true;
        Promise.all([
            loadScript(this, chartResource + '/chart/Chart.min.js')
        ])
        .then(() => {
            window.Chart.platform.disableCSSInjection = true;
            this.callDrawBarChart();
        })
        .catch((error) => {
            console.log('error:::',error);
        })
    }
    selectTopicDetails(selectedTopic){
        console.log('this.selectedDetail::::',selectedTopic.Id);
        console.log('Name of Topic:::',selectedTopic.Topic_Name__c);
        this.showPerf=true;
        this.selectedTopicName=selectedTopic.Topic_Name__c+' Performance';
        this.selectedDetails=selectedTopic.Id;
        retrieveTopPerformerWrapper({
            strTopicId:selectedTopic.Id
        })
        .then((result) =>{
            console.log('result::::',result);
            this.retrievedTopicSuccess=result;
            console.log('retrievedTopicSuccess::::',this.retrievedTopicSuccess);
            this.retrieveTopicError=undefined;
            this.minMarks=Math.min(...this.retrievedTopicSuccess);
            this.maxMarks=Math.max(...this.retrievedTopicSuccess);
            this.loadChartScript();
        })
        .catch((errorDet) =>{
            this.retrievedTopicSuccess=undefined;
            this.retrieveTopicError=errorDet;
        })
    }

    initializeChartJs(){
        console.log('Inside chart js initialize::::',result);
        var ctx=this.template.querySelector(".chart");
        var linechart= new Chart(ctx, {
            type: 'bar',
            data: {
                //labels: this.retrievedTopicSuccess,
                datasets: [{
                    label: 'Topic Performance',
                    backgroundColor: this.chartbgColor,
                    data: result,
                    fill: true,
                    pointBackgroundColor: "#26B99A",
                    borderColor: 'rgba(121, 159, 222, 1)',
                    pointBorderWidth: 2,
                    pointHoverRadius: 5,
                    pointRadius: 2,
                    bezierCurve: true,
                    pointHitRadius: 10
                }]
            },
            options: {
                legend: {
                    position: 'top',
                    padding: 10
                },
                scales: {
                    xAxes: [
                        {
                            beginAtZero: true,
                            ticks: {
                                autoSkip:false
                            }
                        }
                    ]
                },
                responsive: true
            }
        });
    }

    loadChartScript(){
        console.log('Checks 108:::');
        console.log('this.chartjsInitialized:::',this.chartjsInitialized);
        if(this.chartjsInitialized){
            Promise.all([
                loadScript(this,chartResource+'/Chart.js')
            ])
            .then(() => {
                window.Chart.platform.disableCSSInjection = true;
                this.chartjsInitialized=true;
                this.callDrawBarChart();
            })
            .catch((error) => {
                console.log('error:::',error);
            })
        }else{
            console.log('1111');
            Promise.all([
                loadScript(this,chartResource+'/Chart.min.js')
            ])
            .then(() => {
                window.Chart.platform.disableCSSInjection = true;
                this.chartjsInitialized=true;
                this.callDrawBarChart();
            })
            .catch((error) => {
                console.log('error:::',error);
            })
        }
    }

    callDrawBarChart(){
        console.log('call draw bar chart');
        const config={
            type: "doughnut",
            data:{
                datasets:[
                    {
                        label:'Top Performance',
                        data:this.retrievedTopicSuccess,
                        backgroundColor: this.chartbgColor
                    }
                ],
                labels:['Statistics 1','Statistics 2','Statistics 3','Statistics 4','Statistics 5']
            },
            options:{
                responsive: true,
                legend: {
                    display:false
                },
                cutoutPercentage: 75,
                animation: {
                    animateScale: true,
                    animateRotate: true
                },
                title: {
                    display: true,
                    text: "Today's Statistics"
                }
            }
        };
        this.insertCharttoDOM(config);
    }

    insertCharttoDOM(config){
        console.log('chart to dom:::',config);
        const canvas = document.createElement("canvas");
        console.log('canvas:::',canvas);
    const chartNode = this.template.querySelector("div.chart1");
    // clear the old chart from the DOM
    chartNode.innerHTML = "";
    chartNode.appendChild(canvas);
    console.log('chartNode:::',chartNode);
    const ctx = canvas.getContext("2d");
    console.log('ctx::::',ctx);
    //console.log('this.config:::',this.config);
    this.chart= new window.Chart(ctx,config);
    this.chart.canvas.parentNode.style.height = 'auto';
    this.chart.canvas.parentNode.style.width = '100%';
    
    }
}