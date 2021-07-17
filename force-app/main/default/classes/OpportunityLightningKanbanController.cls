public class OpportunityLightningKanbanController {
    public static final String OPP_MOVED = '{0} was moved successfully to {1} and column ordering was updated.';
    
    //////////////////
    //Aura Handlers //
    //////////////////
    
    @AuraEnabled
    public static DataFetchResult initialize() {
        DataFetchResult result = new DataFetchResult();
        
        getOppStatuses( result );
        fetchOpp( result );
        
        return result;
    }
    
    @AuraEnabled
    public static StatusUpdateResult updateOppStatus(Id oppId, String newOppStatus, List<String> ordering) {
        System.debug('OppId:::'+oppId+'~~'+newOppStatus+'~~~~~'+ordering);
        try {
            Opportunity opportunity =[
                SELECT  Id
                ,Name, StageName
                FROM    Opportunity
                WHERE   Id = :oppId
            ];
            if(opportunity.StageName !='') {
                opportunity.StageName= newOppStatus;
            }
            UPDATE opportunity;
            
            /**
* Update all the Opp records
* with the new ordering.
*/
            List<Opportunity> oppToUpdate= new List<Opportunity>();
            Integer counter = 1;
            for( String recId : ordering ) {
                oppToUpdate.add( new Opportunity(Id=recId, Kanban_Sort_Order__c=counter++));
            }
            
            UPDATE oppToUpdate;
            
            return new StatusUpdateResult(
                TRUE,
                'Success',
                String.format( OPP_MOVED, new List<String>{ opportunity.Name, newOppStatus})
            );
        }
        catch( Exception ex ) {        
            return new StatusUpdateResult(
                FALSE,
                'Error',
                ex.getMessage()
            );
        }
    }        
    
    ///////////////////
    //Public Classes //
    ///////////////////
    
    public class Column {
        @AuraEnabled
        public String label 					{ get; set; }
        
        @AuraEnabled
        public Boolean isDropEnabled 			{ get; set; }
        
        public Column( String label, Boolean isDropEnabled ) {
            this.label = label;
            this.isDropEnabled = isDropEnabled;
        }
    }
    
    public class DataFetchResult {
        @AuraEnabled
        public List<Column> columns        		{ get; set; }
        
        @AuraEnabled
        public Map<String, List<Opportunity>> rows    	{ get; set; }
    }
    
    public class StatusUpdateResult {
        @AuraEnabled
        public Boolean isSuccess				{ get; set; }
        
        @AuraEnabled
        public String title						{ get; set; }
        
        @AuraEnabled
        public String message					{ get; set; }
        
        public StatusUpdateResult( Boolean isSuccess, String title, String message ) {
            this.isSuccess  = isSuccess;
            this.title      = title;
            this.message    = message;
        }
    }
    
    ///////////////////////////
    //Private Helper Methods //
    ///////////////////////////
    
    static void getOppStatuses( DataFetchResult result ) {
        try {
            result.columns = new List<Column>();
            
            OpportunityKanbanSettings__c settings = OpportunityKanbanSettings__c.getInstance( UserInfo.getOrganizationId() );
            
            Set<String> dropProhibtedCols = new Set<String>();
            if( settings.Drop_Prohibited_Columns__c != NULL ) {            
                dropProhibtedCols.addAll( settings.Drop_Prohibited_Columns__c.split( ',' ) );
            }
            
            List <Opportunity_Stages__mdt> oppStagesList=[Select ApiName__c, MasterLabel__c from Opportunity_Stages__mdt]; 
            
            for( OpportunityStage status : [
                SELECT  Id
                ,ApiName
                ,SortOrder
                ,MasterLabel
                FROM    OpportunityStage
                ORDER BY SortOrder ASC
            ]
               ) {
                   for(Opportunity_Stages__mdt opp: oppStagesList){
                       if(status.MasterLabel == opp.MasterLabel__c)
                           result.columns.add(
                               new Column(
                                   status.MasterLabel,
                                   !dropProhibtedCols.contains( status.MasterLabel )
                               )
                           );
                   }
                   
               }
        }catch(Exception e){
            system.debug('error in getOppStatuses::::'+e.getMessage());
        }
    }
    
    static void fetchOpp( DataFetchResult result ) {
        try {
            List<Opportunity> opps = [
                SELECT  Id
                ,Name
                ,Account.Name
                ,Amount
                ,Type
                ,LeadSource 
                ,StageName
                ,Kanban_Sort_Order__c
                FROM    Opportunity
                ORDER BY Kanban_Sort_Order__c ASC
            ];
            
            result.rows = new Map<String, List<Opportunity>>();
            
            for( Column col : result.columns ) {
                result.rows.put( col.label, new List<Opportunity>{} );
            }
            if(!opps.isEmpty()){
                for( Opportunity opp : opps ) {
                    if( result.rows.containsKey( opp.StageName ) ) {
                        result.rows.get( opp.StageName ).add( opp );
                    }
                }
            }
        }catch(Exception e){
            system.debug('Error in fetchOpp::::'+e.getStackTraceString());
        }
    }
}