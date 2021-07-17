({
	doInit : function(component, event, helper) {
        console.log('inside doInit');
		var action= component.get("c.getQAData");
        action.setCallback(this, function(response){
           var state=response.getState();
            console.log('state::::',state);
            if(state === 'SUCCESS' || state === 'DRAFT'){
                var respValue= response.getReturnValue();
                console.log('RespValue::::',respValue);
                component.set('v.responseQA', respValue);
                console.log('length::::',respValue.length);
            }
        });
         $A.enqueueAction(action);
	}
})