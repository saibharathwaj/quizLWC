public with sharing class DynamicMultiSelectPicklistApex {
    
    @AuraEnabled
    public static List<DynamicMultiSelectPicklistApex.dynamicInner> getSecondDetails(String selectedRecords){
        List<String> secondList= new List<String>();
        List<DynamicMultiSelectPicklistApex.dynamicInner> dynamicInnerList= new List<DynamicMultiSelectPicklistApex.dynamicInner>();
        if(selectedRecords != '' && selectedRecords !=null){
            try {
                if(selectedRecords.contains(',')){
                    secondList=selectedRecords.split(',');
                    for(String second: secondList){
                        dynamicInnerList.add(new DynamicMultiSelectPicklistApex.dynamicInner(second,second));
                    }
                }
            }catch(Exception e){
                
            }
        }
        System.debug('secondList:::::::'+secondList);
        return dynamicInnerList;
    }
    
    public class dynamicInner{
        
        @AuraEnabled
        public String label {get;set;}
        
        @AuraEnabled
        public String value {get; set;}
        
        public dynamicInner(String label, String value){
            this.label=label;
            this.value=value;
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Survey_Response__c> getSurveyDetails(){
        return [Select Id, Name, Account__r.Name, Rating__c, Survey_Content__c from Survey_Response__c order by createddate LIMIT 10];
    }
    
    @AuraEnabled
    public static String updateSurveyResponse(Id recordId, Decimal rating){
        // Database.SaveResult[] srList;
        System.debug('Record Id::::'+recordId+'~~~~~Rating :::::'+rating);
        List<Survey_Response__c> surveyList= new List<Survey_Response__c>();
        String message;
        try {
            if(recordId != null && rating !=0){
                Survey_Response__c obj= new Survey_Response__c(Id= recordId);
                obj.Rating__c=rating;
                surveyList.add(obj);
                System.debug('surveyList:::::'+surveyList);
                Database.SaveResult[] srList= Database.update(surveyList, false);
                System.debug('srList::::'+srList);
                for(Database.SaveResult sr: srList){
                    if(sr.isSuccess()){
                        System.debug('Successfully Updated:::'+sr.Id);
                        message='SUCCESS';
                    }else{
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.');                   
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Account fields that affected this error: ' + err.getFields());
                            message='FAILURE';
                        }
                        
                    }
                }
            }
            
            
            
        } catch(Exception e){
            System.debug('Error in updateSurveyResponse:::'+e.getMessage()+'~~~'+e.getLineNumber()+'~~~~'+e.getCause());
        }
        System.debug('message:::::'+message);
        return message;
    }
    
}