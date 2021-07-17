import { LightningElement, track, wire } from 'lwc';
import CORONA1 from '@salesforce/resourceUrl/corona1';
import CORONA2 from '@salesforce/resourceUrl/corona2';
import CORONA3 from '@salesforce/resourceUrl/corona3';
import getAllCountryDetails from '@salesforce/apex/CoronaApex.getAllCountryDetails';
export default class CoronaComponent extends LightningElement {

corona1Img= CORONA1;
corona2Img= CORONA2;
corona3Img= CORONA3;
@track columns=[
    {
        label: 'Country',
        fieldName:'country',
        type:'text',
        sortable:true
    },
    {
        label: 'Cases',
        fieldName: 'cases',
        type: 'number',
        sortable: true
    },
    {
        label: 'Today Cases',
        fieldName: 'todayCases',
        type:'number',
        sortable:true
    },
    {
        label: 'Deaths',
        fieldName: 'deaths',
        type: 'number',
        sortable:true
    },
    {
        label:'Today Deaths',
        fieldName:'todayDeaths',
        type:'number',
        sortable:true
    },
    {
        label: 'Recovered',
        fieldName:'recovered',
        type:'number',
        sortable:true
    },
    {
        label:'Active',
        fieldName:'active',
        type:'number',
        sortable:true
    },
    {
        label:'Critical',
        fieldName:'critical',
        type:'number',
        sortable:true
    }
];

    
@track error;
@track data;

connectedCallback(){
    this.defaultCountryDetail();
}

defaultCountryDetail() {
    //alert('inside:::::');
    getAllCountryDetails()
            .then( result => {
            console.log('result Data::::', result);
            //alert('data:::'+result);
            this.data=result;
            console.log(JSON.stringify(result, null, '\t'));
            this.error=undefined;
        })
            .catch(error => {
            this.data=undefined;
            this.error=error;
        });
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