({
    doInit : function(component, event, helper) {
        console.log('Dynamic Init::::');
        var initRecord={'sobjectType':'Account',
                        'Name':'',
                        'Industry':'',
                        'Type':'',
                        'Rating':''};
       console.log('v.records',initRecord);
    },
    
    addRows: function(component,event,helper){
        var addRec={'sobjectType':'Account',
                        'Name':'',
                        'Industry':'',
                        'Type':'',
                        'Rating':''};
        var existingRecords= component.get('v.records');
        existingRecords.push(addRec);
        component.set('v.records', existingRecords);
    },
    
    remove: function(component,event,helper){
        var pos=event.target.name;
        var existingRecords= component.get('v.records');
        console.log('event position::::', pos);
        existingRecords.splice(pos,1);
        component.set('v.records',existingRecords);
    },
    
    saveAccount: function(component,event,helper){
        var existingRecords= component.get('v.records');
        console.log('getAcc:::', existingRecords);
        var validRecords=[];
        for(var i=0; i< existingRecords.length; i++){
            if(existingRecords[i].Name !=''){
                validRecords.push(existingRecords[i]);
            }
        }
        component.set('v.records',validRecords);
        component.set('v.rows',validRecords.length);
       // console.log('Valid Records::::', JSON.stringify(validRecords));
        console.log('Length Valid Records::::', validRecords.length);
        var action = component.get("c.insertAccounts");
        action.setParams({
            records : component.get("v.records")
        });
        console.log('esep params:::');
        action.setCallback(this, function(response){
            var state= response.getState();
            console.log('Inside State::::', state);
            if(state === 'SUCCESS' || state === 'DRAFT'){
                var toastEvent=$A.get("e.force:showToast");
                toastEvent.setParams({
                    "title":"Success !!!",
                    "message": "Records Saved Successfully !!!!",
                    "duration":"3000",
                    "type":"success"
                });
                toastEvent.fire();
                component.set('v.visible', true);
                window.setTimeout(
                    $A.getCallback(function() {
                        component.set('v.visible',false);
                    }),3000
                );
            } else if(state === 'ERROR' || state === 'WARNING'){
                var toastEvent=$A.get("e.force:showToast");
                toastEvent.setParams({
                    "title":"Message",
                    "message":"No Records Saved !!!!!",
                    "type":"error"
                });
                toastEvent.fire();
            }
        });
       $A.enqueueAction(action);

    }
})