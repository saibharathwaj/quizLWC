({
    afterScriptsLoaded : function(component, event, helper) {
        var domEl = component.find("ratingArea").getElement();
        var currentRating = component.get('v.value');
        var readOnly = component.get('v.readonly');
        var maxRating = 5;
        var callback = function(rating) {
            component.set('v.value',rating);
        }
        component.ratingObj = rating(domEl,currentRating,maxRating,callback,readOnly);
    },

    onValueChange: function(component,event,helper) {
        if (component.ratingObj) {
            var value = component.get('v.value');
            //console.log('val:::::', value);
            //console.log('ids:::::',component.get('v.ids'));
          //  console.log('surveyContent::::',compoent.get('v.surveyContent'));
            component.ratingObj.setRating(value,false);
        }
        var arr= component.get('v.ids').split('~');
        var idm= arr[0];
        console.log('ids::::', idm);
        var action= component.get("c.updateSurveyResponse");
        action.setParams({
            recordId: idm,
            rating: component.get('v.value')
        });
        action.setCallback(this, function(response){
            alert('resp::::'+response.getState());
            var state= response.getState();
            if(state === 'SUCCESS'){
                var responseVal= response.getReturnValue();
                alert('Great ! You have given new rating to this Survey Response::');
               // component.set('v.currentRating',component.get('v.newRating'));
                //$(".star-rating").toggle();
            }
        });
        $A.enqueueAction(action);
    }
})