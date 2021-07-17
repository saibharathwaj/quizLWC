import { LightningElement, api, track } from 'lwc';
import getStateWideDetails from '@salesforce/apex/CoronaStateWiseApex.getStateWideDetails';
import getStateWiseImpactsCOVID from '@salesforce/apex/CoronaStateWiseApex.getStateWiseImpactsCOVID';
const columns = [
    { label: 'State Name', fieldName: 'state' },
    { label: 'Confirmed', fieldName: 'confirmed' ,type:'number',cellAttributes: { class: 'slds-text-color_error slds-text-title_bold'}},
    { label: 'Active', fieldName: 'active', type:'number',cellAttributes: { class: 'slds-text-color_warning slds-text-title_bold'}},
    { label: 'Recovered', fieldName: 'recovered',type:'number',cellAttributes: { class: 'slds-text-color_success slds-text-title_bold'}},
    { label: 'Deaths', fieldName: 'deaths',type:'number',cellAttributes: { class: 'slds-text-color_error slds-text-title_bold'}},
];

const districtTableColumns = [
    { label: 'District Name', fieldName: 'districtName' },
    { label: 'Confirmed', fieldName: 'confirmed' ,type:'number',cellAttributes: { class: 'slds-text-color_error slds-text-title_bold'}},
  ];

export default class CovidData extends LightningElement {
    @api nationalTotal;
    @api nationalData;
    @api stateData;
    error;
    @track columns=columns;
    @track districtTableColumns=districtTableColumns;
    @track states=[];
    @track value='Tamil Nadu';

    connectedCallback(){
        getStateWideDetails()
        .then(result => {
            var data= result.filter(function(el){
                return el.state === 'Total';
            });
            if(data !=undefined){
                this.nationalTotal=data[0];
            }
            var stateData= result.filter(function(el) {
                return el.state !='Total';
            });
            if(stateData !=undefined){
                this.nationalData=stateData;
            }
            console.log('national data:::', this.nationalData);
            for(var key in this.nationalData){
                console.log('state Details:::', result[key].state);
                var sts={
                    label: result[key].state,
                    value: result[key].state
                };
                console.log('sts::::',sts);
                this.states.push(sts);
            }
           // this.handleChange(null);
            console.log('States::::', JSON.stringify(this.states));
        })
        .catch(error => {
            this.error=error;
            console.log(JSON.stringify(error));
        })
    }
    handleChange(event){
        if(event == null){
            this.value='Tamil Nadu';
        } else {
            this.value=event.detail.value;
        }
        console.log('value:::', this.value);
        getStateWiseImpactsCOVID(
            {
                'stateName':this.value
            }
        )
        .then(result => {
            console.log('resp from result;::', result);
            this.stateData=result;
        })
        .catch(error => {
            this.error=error;
            console.log(JSON.stringify(this.error));
        })
    }
}