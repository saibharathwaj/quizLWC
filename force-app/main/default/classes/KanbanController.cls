public class KanbanController {
	@AuraEnabled
    public static kanbanWrap getKanbanWrap(String objName, String[] objFields, String kanbanField) {
        List<String> lstPickvals=new List<String>();
        List <Opportunity_Stages__mdt> oppStagesList=[Select ApiName__c, MasterLabel__c from Opportunity_Stages__mdt]; 
        for (Schema.PicklistEntry a : Schema.getGlobalDescribe().get(objName).getDescribe().fields.getMap().get(kanbanField).getDescribe().getPickListValues()) {
            for(Opportunity_Stages__mdt opp: oppStagesList){
                if(a.getValue() == opp.MasterLabel__c) {
                     lstPickvals.add(a.getValue());
                }
            }
        }
           
        System.debug('list values::::'+lstPickvals);
        
        String query = 'SELECT Id, ';
        for(String s:objFields){
            query += s+' ,';
        }
        query = query.removeEnd(',');
        query += ' FROM ' + objName;
        System.debug('qq  ' + query);
        
        return new kanbanWrap(Database.query(query), lstPickvals);
    }
    
    @AuraEnabled
    public static String getUpdateStage(Id recId, String kanbanField, String kanbanNewValue) {
        SObject o1 = recId.getSObjectType().newSObject(recId);
        o1.put(kanbanField,kanbanNewValue);
        update o1;
        return 'Success';
    }
    
    public class kanbanWrap{
        @AuraEnabled
        public List<sObject> records {get;set;}
        @AuraEnabled
        public List<String> pickVals {get;set;}
        public kanbanWrap(List<sObject> recs, List<String> pVals){
            this.records = recs;
            this.pickVals = pVals;
        }
    }
}