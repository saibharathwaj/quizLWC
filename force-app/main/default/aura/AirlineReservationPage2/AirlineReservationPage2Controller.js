({
    fetchFlightDetails : function(component, event, helper) {
        component.set('v.mycolumns',[
            {label: 'Flight Name', fieldName:'Flight_Name__c', type: 'text'},
            {label: 'Flight Departure Time' , fieldName:'Flight_Departure_Time__c', type:'datetime'},
            {label: 'Flight Arrival Time', fieldName:'Flight_Arrival_Time__c', type:'datetime'},
            {label: 'Duration', fieldName:'Duration__c', type:'number'},
            {label: 'Book Ticket', type:'button', initialWidth: 135, 
             typeAttributes: {
                 label: 'Book',
                 name: 'Book',
                 iconName: 'utility:bookmark',
                 iconPosition:'left'
             }}
        ]);
        //calling apex class for fetching the details
        var action=component.get('c.getFlightDetails');
        action.setParams({
            
        });
        action.setCallback(this, function(response) {
            var state=response.getState();
            if(state === 'SUCCESS'){
                component.set('v.flightlist', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    bookFlight: function(component,event,helper){
        var recId= event.getParam('row').Id;
        console.log('recId',recId);
        var recName=event.getParam('row').Flight_Name__c;
        console.log('rec Name::',recName);
        var actionName=event.getParam('action').name;
        if(actionName === 'Book') {
            alert('Book::::');
            var navService = component.find("navService");
            var pageReference = {
                
                "type": "standard__component",
                "attributes": {
                    "componentName": "c__AirlineReservationPage3"    
                },    
                "state": {
                    "c__flightName":recName,
                    "c__flightId":"AT1908756"
                }
            };
            component.set("v.pageReference", pageReference);
            var defaultUrl = "#";
            navService.generateUrl(pageReference)
            .then($A.getCallback(function(url) {
                component.set("v.url", url ? url : defaultUrl);
            }), $A.getCallback(function(error) {
                component.set("v.url", defaultUrl);
            }));
            var navService = component.find("navService");
            // Uses the pageReference definition in the init handler
            var pageReference = component.get("v.pageReference");
            event.preventDefault();
            navService.navigate(pageReference);
        }
    }
})