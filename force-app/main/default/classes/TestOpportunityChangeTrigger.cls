@isTest
public class TestOpportunityChangeTrigger {

    @isTest
    static void testCreateAndUpdateOpportunity(){
        // Enable all Change Data Capture entities for notifications.
    Test.enableChangeDataCapture();
    // Insert an Employee test record
    insert new Opportunity(Name='Sell 100 Widgets', StageName='Prospecting', CloseDate=Date.today().addMonths(3));
    // Call deliver to fire the trigger and deliver the test change event.
    Test.getEventBus().deliver();
    // VERIFICATIONS
    // Check that the change event trigger created a task.
    Task[] taskList = [SELECT Id,Subject FROM Task];
    System.assertEquals(1, taskList.size(),
      'The change event trigger did not create the expected task.');
    // Update employee record
    Opportunity[] empRecords = [SELECT Id,Name, StageName, CloseDate FROM Opportunity];
    // There is only one test record, so get the first one
    Opportunity emp = empRecords[0];
    // Debug
    System.debug('Retrieved employee record: ' + emp);
    // Update one field and empty another
    emp.StageName='Closed Won';
        //emp.isWon=true;
    update emp;
    // Call deliver to fire the trigger for the update operation.
    Test.getEventBus().deliver();
    // VERIFICATIONS
    // Check that the change event trigger created a task.
    // We should have two tasks now, including one from the first trigger invocation.
    Task[] taskList2 = [SELECT Id,Subject FROM Task];
    System.assertEquals(2, taskList2.size(),
      'The change event trigger did not create the expected task.');
    }
}