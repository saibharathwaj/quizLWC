({
	doInit : function(component, event, helper) {
		component.set('v.gridColumns',
                     [
                         { label:'name', fieldName: 'name', type:'text' },
                         { label:'type', fieldName: 'type', type:'text' },
                         { label:'industry', fieldName: 'industry', type:'text' },
                         { label:'ownerName', fieldName: 'ownerName', type:'text' }
                     ]);
       
        var action= component.get("c.getTreeGridDetails");
        action.setCallback(this, function(response) {
            var state=response.getState();
            if(state === 'SUCCESS'){
                var data= response.getReturnValue();
                var dataJson= JSON.parse(JSON.stringify(data).split('items').join('_children'));
                console.log('dataJson:::', dataJson);
                component.set('v.gridData', JSON.parse(dataJson));
        //        component.set('v.isLoading', false);
            }
        });
        $A.enqueueAction(action);
	},
    
    handleRowToggle: function(component,event,helper){
        var rowName=event.getParam('name');
        var isExpanded=event.getParam('isExpanded');
        var hasChildrenContent= event.getParam('hasChildrenContent');
        var row= event.getParam('row');
        var expandedRows=component.find('treegrid_async').getCurrentExpandedRows();
        if(hasChildrenContent === false){
      //      component.set('v.isLoading', true);
        }
    },
    
    handleRowSelection: function(component,event,helper){
        var selectedRows= component.find('treegrid_async').getSelectedRows();
        console.log('selectedRows:::::',selectedRows);
        var selectedRecords=[];
        for(var i=0; i< selectedRows.length; i++){
            selectedRecords.push(selectedRows[i].name);
        }
        console.log('selectedRecords::::', selectedRecords);
        
    }
})