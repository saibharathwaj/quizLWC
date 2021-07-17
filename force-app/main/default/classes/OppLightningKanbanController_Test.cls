@isTest
private class OppLightningKanbanController_Test {
    private static testMethod void initialize_Test() {
        opportunityLightningKanbanController.initialize();
    }
    
    private static testMethod void updateOppStatus_Test() {
        Test.startTest();
        List<String> ordering = new List<String>();
        Id AdminProfileID = [Select Id From profile Where Name = 'System Administrator' Limit 1].Id;
        Id RoleID = [Select Id From UserRole Where PortalType = 'None' Limit 1].Id;
        User thisUser = new User(
            email='test@gmail.com',
            profileid = AdminProfileID ,
            userroleid = RoleID,
            UserName='testmail@gmail.com.devone',
            alias='Admin',
            TimeZoneSidKey='America/New_York',
            LocaleSidKey='en_US',
            EmailEncodingKey='ISO-8859-1',
            LanguageLocaleKey='en_US',
            FirstName = 'testAdminFirstNameDevone',
            LastName = 'testAdminLastNameDevtwo',
            IsActive = true
        );
        insert thisUser;
        System.runAs(thisUser){
            Opportunity newOpp1 = new Opportunity();
            newOpp1.Name = 'Test Opportunity1';
            newOpp1.Amount = 10.00;
            newOpp1.CloseDate  = Date.today();
            newOpp1.StageName='Closed Won';
            newOpp1.LeadSource='Web';
            INSERT newOpp1;
            
            ordering.add( newOpp1.Id );
            
            Opportunity newOpp2 = new Opportunity();
            newOpp2.Name = 'Test Opportunity2';
            newOpp2.Amount = 11.00;
            newOpp2.CloseDate  = Date.today();
            newOpp2.StageName='Closed Lost';
            newOpp2.LeadSource='Web';
            INSERT newOpp2;
            
            ordering.add( newOpp2.Id );
            opportunityLightningKanbanController.updateOppStatus( newOpp1.Id, 'Closed-Won', ordering );
        }
        
        Test.stopTest();
        
    }
    
}