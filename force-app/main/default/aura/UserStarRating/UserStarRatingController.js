({
	doInit : function(component, event, helper) {
		var action= component.get("c.getSurveyDetails");
        action.setParams({
            
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.set('v.surveyDetails',response.getReturnValue());
            }
            
        });
        $A.enqueueAction(action);
        //starRating(component,event,helper);
	},
    
    starRating: function(component,event,helper){
        alert('details::::::::');
        var ctarget= event.currentTarget;
        var id_str= ctarget.dataset.value;
        console.log('test starRating::::', id_str);
        var ratingElement= component.find('starRating').getElement();
        console.log('ratingElement::::::', ratingElement);
        var resultArr= id_str.toString().split('~');
        var ids= resultArr[0];
        var currRating= resultArr[1];
        console.log('ids:::::',ids);
        console.log('currRating::::',currRating);
        component.set('v.currentRating',currRating);
        $(ratingElement).raty('set',
                              { score : currRating});
        $(".star-rating").toggle();
        $(ratingElement).raty({
            starOff: '/resource/RatingPlugin/images/star_off_darkgray.png',
            starOn: '/resource/RatingPlugin/images/star_on.png', 
            click: function(score,evt){
                if(score == null) score=0;
                if(component.get('v.currentRating') !=score) {
                    var res= confirm('Click OK button to confirm update Rating');
                    if(res){
                        component.set('v.newRating',score);
                        $(".star-rating").toggle();
                        helper.updateRating(component, ids,score);
                    } else{
                        return false;
                    }
                }
            }
        })
    }
})