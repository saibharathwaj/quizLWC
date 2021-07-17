({
	doInit : function(component, event, helper) {
		var opRoles=[
            { id: 1, label:'--None--', selected: true, value:'None' },
            { id: 2, label: 'Senior Manager', value: 'Senior Manager'},
            { id: 3, label: 'Manager',value: 'Manager'},
            { id: 4, label: 'Tech Lead', value:'Tech Lead'},
            { id: 5, label: 'Senior Associate', value: 'Senior Associate'},
            { id: 6, label: 'Associate', value:'Associate'}
         ];
        component.set('v.optionsRole',opRoles);
        console.log('OpRoles:::',opRoles);
        
        var secQuiz= [
            { id:1, label: '--None--', selected: true, value: 'None' },
            { id: 2 , label: 'What is your favourite color ?' , value: 'What is your favourite color ?' },
            { id: 3, label: 'What is your favourite car?' , value: 'What is your favourite car ?' },
            { id: 4, label: 'What is your favourite subject ? ', value: 'What is your favourite subject ?' },
            { id: 5, label: 'What is your favorite destination ?' , value: 'What is your favourite destination ?'},
            { id: 6, label: 'What is your hobby? ', value: 'What is your favourite hobby?' }
       ];
        component.set('v.secQuiz',secQuiz);
	},
    
    selectRoleValue: function(component,event,helper){
        console.log(event);
       var selValue=event.getSource().get('v.value');
        console.log('Selected Value'+selValue);
        
    },
    
    doValueComb: function(component,event,helper){
        console.log('value com::');
       var selValue=event.getSource().get('v.value');
        console.log('Selected Value'+selValue);
        /*
        var ot= component.get('v.secQuiz');
        console.log(tot.length);
        for(var i=tot.length-1; i>=0;i--){
            if(tot[i] && (tot[i].id === selValue)){
               tot.splice(i,1);
               }
        }
        component.set('v.secQuiz',tot);*/
    },
    
    doChange: function(component,event,helper){
        alert('iside');
        var index=event.target.dataset.index;
        console.log('index:::',index);
        var leads=component.get('v.secQuiz');
        leads.splice(index,1);
        component.set('v.secQuiz',leads);
    }
})