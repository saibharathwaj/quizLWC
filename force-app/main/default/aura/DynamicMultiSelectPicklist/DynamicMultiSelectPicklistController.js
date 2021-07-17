({
	doInit : function(component, event, helper) {
		var opt=[];
        for(var i=1; i<=5; i++){
            if(i ==1){
                opt.push({
                    label: 'Items '+i,
                    isChecked:true
                });
            } else{
                opt.push({
                    label: 'Items '+i,
                    isChecked:false
                });
            }
        }
        component.set('v.options',opt);
        helper.selectOptionHelper(component, 'Item 1', 'true');
	},
    
    openDropdown: function(component, event, helper){
        $A.util.addClass(component.find('dropdown'), 'slds-is-open');
        $A.util.removeClass(component.find('dropdown'), 'slds-is-close');
    },
    
    closeDropdown: function(component,event,helper){
        $A.util.addClass(component.find('dropdown'), 'slds-is-close');
        $A.util.removeClass(component.find('dropdown'), 'slds-is-open');
    },
    
    selectOption: function(component,event,helper){
        var label= event.currentTarget.id.split('#BP#')[0];
        var isCheck= event.currentTarget.id.split('#BP#')[1];
        console.log('label::::'+label+'~~~~~ is Check :::'+isCheck);
        helper.selectOptionHelper(component, label, isCheck);
    },
    
    handleClick: function(component,event,helper){
        alert('in:::'+component.get('v.selectedOptionItems'));
        var action= component.get("c.getSecondDetails");
        action.setParams({
            selectedRecords:component.get("v.selectedOptionItems")
        });
        //console.log('pram::::');
        action.setCallback( this, function(response){
            console.log('idsds');
           var state= response.getState();
            console.log('state::::', state);
            var op= response.getReturnValue();
            console.log('op::::',op);
            component.set('v.availableOptions',op);
            console.log('jjjjjjjjjjj::::',component.get('v.availableOptions'));
        });
        $A.enqueueAction(action);

    },
    
    handleOptionChange: function(component,event,helper){
        console.log('event:::',event);
    }
})