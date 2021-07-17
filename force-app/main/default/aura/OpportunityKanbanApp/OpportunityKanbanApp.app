<aura:application extends="force:slds">
   <!-- <c:OpportunityKanban/>-->
    <c:DragandDropKanban  objName="Opportunity" 
                         objFields="['Name', 'AccountId', 'Account.Name', 'CloseDate', 'StageName', 'Amount']"
                         kanbanPicklistField="StageName"/>
</aura:application>