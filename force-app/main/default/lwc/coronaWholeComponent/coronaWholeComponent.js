import { LightningElement,track,api } from 'lwc';
import getStateWideDetails from '@salesforce/apex/CoronaStateWiseApex.getStateWideDetails';
import getCaseTimeSeriesDetails from '@salesforce/apex/CoronaStateWiseApex.getCaseTimeSeriesDetails';
import getAllTestedLabsDetails from '@salesforce/apex/CoronaStateWiseApex.getAllTestedLabsDetails';
import getStateWiseImpacts from '@salesforce/apex/CoronaStateWiseApex.getStateWiseImpacts';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import C3 from '@salesforce/resourceUrl/c3';//load the c3 and d3 from the static resources.
import D3 from '@salesforce/resourceUrl/d3';
export default class CoronaWholeComponent extends LightningElement {
    @track worldFlag=false;
    @track indiaFlag=false;
    @track tnFlag= false;
    @track statFlag=false;
    @track testedResultflag=false;
    @api chartData;
    @track chart;
    @track loadingInitialized=false;
    librariesLoaded = false;
    @track statesColumn=[
        {
            label: 'State',
            fieldName:'state',
            type:'text',
            sortable:true
        },
        {
            label: 'Active',
            fieldName: 'active',
            type: 'number',
            sortable: true
        },
        {
            label: 'Confirmed',
            fieldName: 'confirmed',
            type:'number',
            sortable:true
        },
        {
            label: 'Recovered',
            fieldName: 'recovered',
            type: 'number',
            sortable:true
        },
        {
            label:'Deaths',
            fieldName:'deaths',
            type:'number',
            sortable:true
        }
    ];
    @track testedLabs;
    @track statesData;
    @track statesError;

    @track statewiseColumn=[
        {
            label:'District Name',
            fieldName:'districtName',
            type:'text',
            sortable:true
        },
        {
            label:'Confirmed',
            fieldName:'confirmed',
            type:'number',
            sortable:true
        }
        
    ];
    @track statewiseData;
    @track statewiseError;
    worldClick(){
       // alert('worldClick::');
        this.worldFlag=true;
        this.indiaFlag=false;
        this.tnFlag=false;
        this.statFlag=false;
        this.testedResultflag=false;
    }

    indiaClick(){
        //alert('india click');
        this.indiaFlag=true;
        this.worldFlag=false;
        this.tnFlag=false;
        this.statFlag=false;
        this.testedResultflag=false;
    }

    tnClick() {
        //alert('tn click');
        this.tnFlag=true;
        this.indiaFlag=false;
        this.worldFlag=false;
        this.statFlag=false;
        this.testedResultflag=false;
    }

    statClick(){
        //alert('stat click');
        this.statFlag=true;
        this.tnFlag=false;
        this.indiaFlag=false;
        this.worldFlag=false;
        this.testedResultflag=false;
    }

    testedResultClick(){
        //alert('testedResultClick');
        this.testedResultflag=true;
        this.statFlag=false;
        this.tnFlag=false;
        this.indiaFlag=false;
        this.worldFlag=false;
    }
    @track testedErrors;
    @track stageData;
    @track stageError;
    connectedCallback(){
        this.defaultStateWise();
        this.defaultTestedLabs();
        this.defaultStatewiseDatas();
        this.defaultStage();
    }
    defaultStage(){
        getCaseTimeSeriesDetails()
        .then(result => {
            console.log('the result state wise:::', result);
            this.stageData=result;
            this.chartData=stageData;
            this.stageError=undefined;
        })
        .catch(error => {
            this.stageData=undefined;
            this.stageError=error;
        })
    }
    defaultStatewiseDatas(){
        getStateWiseImpacts()
                    .then(result => {
                        console.log('the result state wise:::', result);
                        this.statewiseData=result;
                        this.statewiseError=undefined;
                    })
                    .catch(error => {
                        this.statewiseData=undefined;
                        this.statewiseError=error;
                    })
    }
    defaultTestedLabs(){
        getAllTestedLabsDetails()
                    .then(result => {
                        console.log('result from state:::::',result);
                        this.testedLabs=result;
                        this.testedErrors=undefined;
                    })
                    .catch(error => {
                        this.testedLabs=undefined;
                        this.testedErrors=error;
                    })
    }
     defaultStateWise(){
        getStateWideDetails()
                .then(result => {
                    console.log('result from state:::', result);
                    this.statesData=result;
                    console.log('State Wise::', JSON.stringify(result, null, '\t'));
                    this.statesError=undefined;
                })
                .catch(error => {
                    this.statesData=undefined;
                    this.statesError=error;
                })
     }
     @track defaultSortDirection = 'asc';
@track sortDirection = 'asc';
@track sortedBy;

// Used to sort the 'Age' column
sortBy(field, reverse, primer) {
    const key = primer
        ? function(x) {
                return primer(x[field]);
            }
        : function(x) {
                return x[field];
            };

    return function(a, b) {
        a = key(a);
        b = key(b);
        return reverse * ((a > b) - (b > a));
    };
}

onHandleSort(event) {
    const { fieldName: sortedBy, sortDirection } = event.detail;
    const cloneData = [...this.data];

    cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
    this.data = cloneData;
    this.sortDirection = sortDirection;
    this.sortedBy = sortedBy;
}


}