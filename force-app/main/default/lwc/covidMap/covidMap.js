import { LightningElement, track,wire } from 'lwc';
import getStatesData from '@salesforce/apex/CovidApex.getStatesData';
export default class COVIDMap extends LightningElement {
    @track mapMarkers=[];
    @track error;
    @track results;
    @wire(getStatesData) results;

    connectedCallback(){
        console.log('res:::', this.results);
    }
   // loadingDetails()
    /*wiredStateData({ error, data }){
        console.log('sdsdsd data::::', data);
        console.log('dssdsds',error);
        if(data){
            console.log('data::::'+data);
            data.forEach(dataItem => {
                const Latitude = dataItem.Location__Latitude__s;
                const Longitude = dataItem.Location__Longitude__s;
                this.mapMarkers=[
                        ...this.mapMarkers,
                        {
                            location: {
                                Latitude,Longitude
                            },
                            icon: 'utility:user',
                            title: dataItem.Name,
                        }
                ];
            });
            this.error=undefined;
        }
        if(error){
            this.error=error;
        }
    }*/

}