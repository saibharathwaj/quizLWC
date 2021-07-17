({
	selectOptionHelper : function(component, label, isCheck) {
		var selectedOption='';
        var selectedOptionItems='';
        var allOptions=component.get('v.options');
        var count=0;
        for(var i=0;i<allOptions.length;i++){
            if(allOptions[i].label == label){
                if(isCheck == 'true'){
                    allOptions[i].isChecked= false;
                }else{
                    allOptions[i].isChecked= true;
                }
            }
            if(allOptions[i].isChecked){
                selectedOption=allOptions[i].label;
                if(selectedOptionItems !=''){
                    selectedOptionItems=selectedOptionItems+','+allOptions[i].label;
                }else
                selectedOptionItems+= allOptions[i].label;
                count++;
            }
        }
        if(count > 1){
            selectedOption= count+' items selected';
        }
        
        component.set('v.selectedOptions', selectedOption);
        component.set('v.options', allOptions);
        component.set('v.selectedOptionItems',selectedOptionItems);
        console.log('Helper SelectedOptions:::::',selectedOption);
        console.log('Helper options:::::',allOptions);
        
        
	}
})