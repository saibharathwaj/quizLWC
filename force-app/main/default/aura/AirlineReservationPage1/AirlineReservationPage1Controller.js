({
	doInit : function(component, event, helper) {
		var today= new Date();
        var arrivalDate= new Date();
        component.set('v.today',today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate());
        component.set('v.arrivalDate', today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate());
        console.log('Printing the Depature Date:::',component.get('v.today'));
        console.log('Printing the arrival date ::::', component.get('v.arrivalDate'));
        
     },
    
    handleClick: function(component,event,helper){
        var dest=component.find("fromPlace").get("v.value");
        var arr=component.find("toPlace").get("v.value");
        var trvlprf=component.find("travelPref").get("v.value");
        var depDate=component.find("depDate").get("v.value");
        var arrive=component.find("arrDate").get("v.value");
        console.log("details::"+dest+"~"+arr+"~"+trvlprf+"~"+depDate+"~"+arrive);
         var navService = component.find("navService");
        var pageReference = {
            
            "type": "standard__component",
            "attributes": {
                "componentName": "c__AirlineReservationPage2"    
            },    
            "state": {
                "Test":dest
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
})