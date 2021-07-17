public with sharing class TreeGridApex {

    @AuraEnabled
    public static String getTreeGridDetails(){
        List<Account> accList= [Select Id, Name, Type, Industry, owner.Name, (Select Id , Name from Contacts) from Account];
        Map<Id, Contact> contOppMap= new Map<Id, Contact>([Select Id, Name , (Select Id, Name from Opportunities) from Contact]);
        List<AccountWrapper> accountWrapperList= new List<AccountWrapper>();
        for(Account acc:accList){
            AccountWrapper accWrap = new AccountWrapper();
            accWrap.name=acc.Name;
            accWrap.type=acc.Type;
            accWrap.industry=acc.Industry;
            accWrap.ownerName=acc.owner.Name;
            List<Items> itemList= new List<Items>();
            for(Contact contact: acc.Contacts){
                Items item= new Items();
                item.name= contact.Name;
                List<Items> itList= new List<Items>();
                for(Opportunity opp: contOppMap.get(contact.Id).Opportunities){
                    Items oppItems= new Items();
                    oppItems.name=opp.Name;
                    itList.add(oppItems);
                }
                item.items=itList;
                itemList.add(item);
            }
            accWrap.items=itemList;
            accountWrapperList.add(accWrap);
        }
        return JSON.serializePretty(accountWrapperList);
    }
    
    public class AccountWrapper{
        @AuraEnabled
        public String name {get;set;}
        @AuraEnabled
        public String type {get;set;}
        @AuraEnabled
        public String industry {get;set;}
        @AuraEnabled
        public String ownerName {get;set;}
        @AuraEnabled
        public List<Items> items {get;set;}
    }
    
    public class Items {
        @AuraEnabled
        public String name {get;set;}
        @AuraEnabled
        public List<Items> items {get;set;}
    }
}