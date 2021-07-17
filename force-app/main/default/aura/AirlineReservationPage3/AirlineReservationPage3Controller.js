({
	doInit : function(component, event, helper) {
        console.log('ssssss');
		var pageReference= component.get("v.pageReference");
        if(pageReference){
            console.log('dddd');
            var state=pageReference.state.c__flightName;
            var flightDet= pageReference.state.c__flightId;
           // var fName=state.c__flightName;
            console.log('fName:::',state);
            component.set('v.c__flightName',state);
            component.set('v.flightIdentity', flightDet);
            //console.log('pg:::',pageReference);
            //console.log('check:::', pageReference.state.c__flightName);
        }
	},
    
    handleClick: function(component,event,helper) {
        alert('inside click');
        console.log('Passport Number::',component.get('v.passportNumber'));
        var action=component.get('c.insertReservation');
        action.setParams({
            "flightName":component.get('v.c__flightName'),
            "passportNumber":component.get('v.passportNumber'),
            "address":component.get('v.passengerAddress'),
            "state":component.get('v.passengerState'),
            "noofSeats":component.get('v.passengerTicket'),
            "email":component.get('v.passengerEmail'),
            "passengerName":component.get('v.passengerName'),
            "flightBooked":component.get('v.c__flightName')
        });
         action.setCallback(this, function(response) {
            var state=response.getState();
            if(state === 'SUCCESS'){
                component.set('v.recordInsert', response.getReturnValue());
                console.log('Record Id:::', component.get('v.recordInsert'));
                var toastEvent=$A.get("e.force:showToast");
                toastEvent.setParams({
                    "title":"Success!",
                    "message":"Ticket Booked Successfully !!!!"+component.get('v.recordInsert')
                });
                toastEvent.fire();
                 $A.get('e.force:refreshView').fire();
            }
        });
        $A.enqueueAction(action);
    }
})