@isTest
private class LeadLightningKanbanController_Test {
    private static testMethod void initialize_Test() {
        LeadLightningKanbanController.initialize();
    }
    
    private static testMethod void updateLeadStatus_Test() {
        List<String> ordering = new List<String>();
        
        Lead newTestLead = new Lead();
        newTestLead.LastName = 'Test Lead';
        newTestLead.Company = 'Test Company';
        newTestLead.Status  = 'Open - Not Contacted';
        INSERT newTestLead;
        
        ordering.add( newTestLead.Id );
        
        Lead newTestLead2 = new Lead();
        newTestLead2.LastName = 'Test Lead 2';
        newTestLead2.Company = 'Test Company 2';
        newTestLead2.Status  = 'Open - Not Contacted';
        INSERT newTestLead2;
        
        ordering.add( newTestLead2.Id );
        
        LeadLightningKanbanController.updateLeadStatus( newTestLead.Id, 'Working - Contacted', ordering );
    }

}