global class PicklistCustomApex extends VisualEditor.DynamicPickList {

    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue= new VisualEditor.DataRow('None', 'None');
        return defaultValue;
    }
    
    global override VisualEditor.DynamicPickListRows getValues(){
        VisualEditor.DataRow defaultValue= getDefaultValue();
        Map<String, Schema.SObjectType> schemaMap= Schema.getGlobalDescribe();
        VisualEditor.DynamicPickListRows picklistValues= new VisualEditor.DynamicPickListRows();
        picklistValues.addRow(defaultValue);
        for(String sch: schemaMap.keySet()){
            Schema.SObjectType objToken= schemaMap.get(sch);
            Schema.DescribeSObjectResult objDescribe= objToken.getDescribe();
            VisualEditor.DataRow picklistRowValue= new VisualEditor.DataRow(objDescribe.getLabel(), objDescribe.getName());
            picklistValues.addRow(picklistRowValue);
        }
        return picklistValues;
    }
    
  
    /*@AuraEnabled
    public static List<String> getPicklistValues(String objName){
        
    }*/
    
    
}