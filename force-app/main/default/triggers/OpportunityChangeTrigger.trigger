trigger OpportunityChangeTrigger on OpportunityChangeEvent (after insert) {
	List<Task> taskList= new List<Task>();
    for(OpportunityChangeEvent event: Trigger.New){
        EventBus.ChangeEventHeader header= event.ChangeEventHeader;
        System.debug('Received change event for ' +
      				header.entityName +
      				' for the ' + header.changeType + ' operation.');
        if(header.changetype == 'UPDATE'){
            System.debug('Changed Fields:::');
            for(String field: header.changedfields){
                if(null == event.get(field)){
                    System.debug('Deleted field value (set value) :::'+field);
                } else{
                    system.debug('Changed value::::'+field+', new value:::'+event.get(field));
                }
            }
        }
        if(event.Name !=''){
            System.debug('Name:::'+event.Name);
        }
        if(event.CloseDate !=null){
            System.debug('Close Date::'+event.CloseDate);
        }
        if(event.StageName !=null){
            System.debug('Stage Name:::'+event.StageName);
        }
        if(event.IsWon == true){
            Task ts= new Task();
            ts.subject='Follow up on won opportunities: '+header.recordids;
            ts.OwnerId=header.commituser;
            taskList.add(ts);
        }  
    }
    if(taskList.size() > 0){
        insert taskList;
    }
}