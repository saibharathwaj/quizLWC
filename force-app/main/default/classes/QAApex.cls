public with sharing class QAApex {
	@AuraEnabled
    public static List<QAInner> getQAData() {
        System.debug('Enters into getQAdata::::');
        List<QAInner> qaInnerList= new List<QAInner>();
        QA__mdt[] qaMetadata =[Select Correct_Answer__c, Question__c,Option_1__c,Option_2__c,Option_3__c,Option_4__c from QA__mdt];
        for(QA__mdt qa: qaMetadata){
            QAInner innerObj= new QAInner();
            List<String> innerList= new List<String>();
            innerObj.question=qa.Question__c;
            innerObj.correctAnswer=qa.Correct_Answer__c;
            innerList.add(qa.Option_1__c);
            innerList.add(qa.Option_2__c);
            innerList.add(qa.Option_3__c);
            innerList.add(qa.Option_4__c);
            innerObj.ansOptions=innerList;
            qaInnerList.add(innerObj);
        }
        return qaInnerList;
    }
    
    public class QAInner {
        @AuraEnabled
        public String question {get;set;}
        @AuraEnabled
        public String correctAnswer {get;set;}
        @AuraEnabled
        public List<String> ansOptions {get;set;}
    }
    
}