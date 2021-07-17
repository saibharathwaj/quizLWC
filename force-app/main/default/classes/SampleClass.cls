public with sharing class SampleClass {
    
    public static Map<String,Set<String>> getMapData(){
        String sobject_type='Account';
        Map<String, Set<String>> detailsMap= new Map<String, Set<String>>();
        Set<String> fieldsDet= new Set<String>();
        Map<String, Schema.SObjectType> global_describe=Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> obj_fieldMap=global_describe.get(sobject_type).getDescribe().fields.getMap();
        System.debug('obj_fieldMap:::'+obj_fieldMap);
        for(String fieldName: obj_fieldMap.keySet()){
            String fieldLabel=obj_fieldMap.get(fieldName).getDescribe().getLabel();
            
            Schema.DisplayType fieldDatatype= obj_fieldMap.get(fieldName).getDescribe().getType();
            if(detailsMap.containsKey(String.valueOf(fieldDatatype))){
                Set<String> val= detailsMap.get(String.valueOf(fieldDatatype));
                val.add(String.valueOf(fieldName));
                detailsMap.put(String.valueOf(fieldDatatype), val);
            }else{
                Set<String> val1= new Set<String>();
                val1.add(String.valueOf(fieldName));
                detailsMap.put(String.valueOf(fieldDatatype),  val1);
            }
            
        }
        
        
        System.debug('Map::::'+detailsMap);
        return detailsMap;
    }
}