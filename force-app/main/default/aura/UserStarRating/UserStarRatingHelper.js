({
	updateRating : function(component, ids, score) {
        console.log('Enter updateRating ids:::::',ids);
        console.log('score::::',score);
        var action= component.get("c.updateSurveyResponse");
        action.setParams({
            recordId: ids,
            rating: score
        });
        action.setCallback(this, function(response){
            var state= response.getState();
            if(state === 'SUCCESS'){
                var responseVal= response.getReturnValue();
                alert('Great ! You have given new rating to this Survey Response::');
                component.set('v.currentRating',component.get('v.newRating'));
                $(".star-rating").toggle();
            }
        });
        $A.enqueueAction(action);
	}
})