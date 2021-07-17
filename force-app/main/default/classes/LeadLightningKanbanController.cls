public class LeadLightningKanbanController {
    public static final String LEAD_MOVED = '{0} was moved successfully to {1} and column ordering was updated.';
    
    //////////////////
    //Aura Handlers //
    //////////////////

    @AuraEnabled
    public static DataFetchResult initialize() {
        DataFetchResult result = new DataFetchResult();

        getLeadStatuses( result );
        fetchLeads( result );

        return result;
    }
    
    @AuraEnabled
    public static StatusUpdateResult updateLeadStatus( Id leadId, String newLeadStatus, List<String> ordering ) {
        try {
            Lead lead = [
                SELECT  Id
                        ,Name
                FROM    Lead
                WHERE   Id = :leadId
            ];
        
            lead.Status = newLeadStatus;
            UPDATE lead;
            
            /**
             * Update all the Lead records
             * with the new ordering.
             */
            List<Lead> leadsToUpdate = new List<Lead>();
            Integer counter = 1;
            for( String recId : ordering ) {
                leadsToUpdate.add( new Lead( Id = recId, Kanban_Sort_Order__c = counter++ ) );
            }
            
            UPDATE leadsToUpdate;
        
            return new StatusUpdateResult(
                TRUE,
                'Success',
                String.format( LEAD_MOVED, new List<String>{ lead.Name, newLeadStatus } )
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
        public Map<String, List<Lead>> rows    	{ get; set; }
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
    
    static void getLeadStatuses( DataFetchResult result ) {
        result.columns = new List<Column>();
        
        LeadKanbanSettings__c settings = LeadKanbanSettings__c.getInstance( UserInfo.getOrganizationId() );
        
        Set<String> dropProhibtedCols = new Set<String>();
        if( settings.Drop_Prohibited_Columns__c != NULL ) {            
            dropProhibtedCols.addAll( settings.Drop_Prohibited_Columns__c.split( ',' ) );
        }
        
        for( LeadStatus status : [
                SELECT  Id
                        ,ApiName
                        ,SortOrder
                        ,MasterLabel
                FROM    LeadStatus
                ORDER BY SortOrder ASC
            ]
        ) {
            result.columns.add(
                new Column(
                    status.MasterLabel,
                    !dropProhibtedCols.contains( status.MasterLabel )
                )
			);
        }
    }
    
    static void fetchLeads( DataFetchResult result ) {
        List<Lead> leads = [
            SELECT  Id
                    ,Name
                    ,Title
                    ,Company
                    ,Email
                    ,LeadSource 
                    ,Status
            		,Kanban_Sort_Order__c
            FROM    Lead
            ORDER BY Kanban_Sort_Order__c ASC
        ];
        
        result.rows = new Map<String, List<Lead>>();
        
        for( Column col : result.columns ) {
            result.rows.put( col.label, new List<Lead>{} );
        }
        
        for( Lead lead : leads ) {
            if( result.rows.containsKey( lead.Status ) ) {
                result.rows.get( lead.Status ).add( lead );
            }
        }
    }
}