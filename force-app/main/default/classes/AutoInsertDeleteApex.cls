public with sharing class AutoInsertDeleteApex {
	@AuraEnabled
    public static void insertAccounts(List<Account> records){
        System.debug('Incoming records :::::::'+records);
        if(records.size() > 0 && records != null){
            insert records;
            System.debug('Records inserted::::'+records);
        }
    }
}