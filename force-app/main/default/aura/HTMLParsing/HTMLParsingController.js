({
	doInit : function(component, event, helper) {
		var action=component.get("c.htmlTagParsing");
        action.setCallback(this, function(response){
            var state= response.getState();
            if(state === 'SUCCESS'){
                var responseValue= response.getReturnValue();
                console.log('responseValue:::', responseValue);
                component.set('v.htmlString', responseValue);
            }
        });
        $A.enqueueAction(action);
	}
})