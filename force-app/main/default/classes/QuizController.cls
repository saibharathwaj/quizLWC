/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-16-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   06-01-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class QuizController {
    public QuizController() {

    }
  @AuraEnabled(cacheable=true)
  public static List<SObject> searchObject(String strSearchTerm, String strObject, String strFilterType){
    System.debug('search Obj: input :::'+strSearchTerm+'~~~strObject:::'+strObject+'~~~~'+strFilterType);
    String strQuery;
    List<SObject> lstObjectQuery;
    try{
        if(!String.isEmpty(strFilterType)){
            strQuery='Select Id, Topic_Name__c,isAdvance__c,isBasic__c,isIntermediate__c  from '+String.escapeSingleQuotes(strObject)+' where Topic_Name__c  LIKE \'%'+strSearchTerm+'%\' AND '+strFilterType+' LIMIT 5';
        }else{
            if(!String.isBlank(strSearchTerm)){
                strQuery='Select Id,Topic_Name__c,isAdvance__c,isBasic__c,isIntermediate__c  from '+String.escapeSingleQuotes(strObject)+' where Topic_Name__c  LIKE  \'%'+strSearchTerm+'%\' LIMIT 5';
            }else{
                strQuery='Select Id,Topic_Name__c,isAdvance__c,isBasic__c,isIntermediate__c  from '+String.escapeSingleQuotes(strObject)+' where LastViewedDate !=NULL ORDER BY LastViewedDate DESC LIMIT 5';
            }
        }
        lstObjectQuery=Database.query(strQuery);
    } catch(Exception ex){
        System.debug('Error in exception in searchObject ::::'+ex);
        return null;
    }
    System.debug('lstObjectQuery:::'+lstObjectQuery);
    return lstObjectQuery;
  }  


  @AuraEnabled
  public static UserDetails fetchUserDetails(String strUserName, String strUserEmail){
    UserDetails objUserDetails=new UserDetails();  
    try {
          if(!String.isBlank(strUserName) && !String.isBlank(strUserEmail)) {
              List<Participants__c> lstPartcipants=[Select Id,Name, Participant_Email__c, Participant_Name__c, Participant_Score__c 
              from Participants__c where Participant_Email__c=:strUserEmail and Participant_Name__c=:strUserName];
              if(!lstPartcipants.isEmpty()){
                objUserDetails.strUserName=lstPartcipants[0].Participant_Name__c;
                objUserDetails.strUserEmail=lstPartcipants[0].Participant_Email__c;
                objUserDetails.strUserScore=lstPartcipants[0].Participant_Score__c;
                objUserDetails.strUserId=lstPartcipants[0].Id;
              }else{
                 Participants__c participantObject= new Participants__c();
                 participantObject.Participant_Name__c=strUserName;
                 participantObject.Participant_Email__c=strUserEmail;
                 participantObject.Participant_Score__c=0;
                 insert participantObject;
                 List<Participants__c> lstInsertParticipants=[Select Id,Name,Participant_Email__c, Participant_Name__c, Participant_Score__c 
                 from Participants__c where Id=:participantObject.Id];
                 if(!lstInsertParticipants.isEmpty()){
                    objUserDetails.strUserName=lstInsertParticipants[0].Participant_Name__c;
                    objUserDetails.strUserEmail=lstInsertParticipants[0].Participant_Email__c;
                    objUserDetails.strUserScore=lstInsertParticipants[0].Participant_Score__c;
                    objUserDetails.strUserId=lstInsertParticipants[0].Id;
                 }
              }
          }
      } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
      }
      System.debug('UserDetails:::'+objUserDetails);
      return objUserDetails;
  }

  @AuraEnabled
  public static String fetchFeedbackRequired(String strFeedbackComments, String strParticipantId){
    String result;  
    List<FeedbackRequired__c> lstfeedbackRequired=new List<FeedbackRequired__c>();
    try{
        if(!String.isBlank(strFeedbackComments) && !String.isBlank(strParticipantId)){
            FeedbackRequired__c feedbackRequiredObject=new FeedbackRequired__c();
            feedbackRequiredObject.FeedbackComments__c=strFeedbackComments;
            feedbackRequiredObject.Participants__c=strParticipantId;
            lstfeedbackRequired.add(feedbackRequiredObject);
        }
       if(!lstfeedbackRequired.isEmpty()){
           insert lstfeedbackRequired;
           result='Success';
       }else{
            result='Error';
       }
      }catch(Exception ex){
        System.debug('Exception in fetchFeedbackRequired:::'+ex);
      }
      return result;
  }

  @AuraEnabled
  public static List<QuestionDetailsWrapper> retrieveQuestionDetails(String strTopicId, String strExamLevelName){
    List<QuestionDetailsWrapper> lstQuestionDetailsWrapper= new List<QuestionDetailsWrapper>();
    try{
        for(Question_Details__c questionDetails: [Select Id,Name, Correct_Answers__c, Exam_Level__r.Id, Exam_Level__r.Name, Option_1__c, Option_2__c,
                                                Option_3__c,Option_4__c,Question_Name__c,Tags__c,Topic__r.Id, Topic__r.Name,Type_of_Question__c from Question_Details__c 
                                                where Exam_Level__r.Exam_Name__c=:strExamLevelName and Topic__r.Id=:strTopicId]){
             QuestionDetailsWrapper questionObject= new QuestionDetailsWrapper();
             List<OptionsWrapper> lstOptionWrapperObj=new List<OptionsWrapper>();
             questionObject.strQuestionId=questionDetails.Id;
             questionObject.strQuestionName=questionDetails.Name;
             questionObject.typeOfQuestions=questionDetails.Type_of_Question__c;
             questionObject.strTopicId=questionDetails.Topic__r.Id;
             questionObject.strTopicName=questionDetails.Topic__r.Name;
             questionObject.strTags=questionDetails.Tags__c;
             questionObject.strQuestion=questionDetails.Question_Name__c;
             questionObject.strExamLevelId=questionDetails.Exam_Level__r.Id;
             questionObject.strExamLevelName=questionDetails.Exam_Level__r.Name;
             questionObject.isCheckbox=(questionDetails.Type_of_Question__c.equalsIgnoreCase('Checkbox'))?true:false;
             questionObject.strCorrectAnswers=questionDetails.Correct_Answers__c;
             questionObject.strUserSelectedAnswer=(questionDetails.Type_of_Question__c.equalsIgnoreCase('Checkbox'))?'':'';
             OptionsWrapper optionWrapperObject1=new OptionsWrapper();
             optionWrapperObject1.label=questionDetails.Option_1__c;
             optionWrapperObject1.value=questionDetails.Option_1__c;
             OptionsWrapper optionWrapperObject2=new OptionsWrapper();
             optionWrapperObject2.label=questionDetails.Option_2__c;
             optionWrapperObject2.value=questionDetails.Option_2__c;
             OptionsWrapper optionWrapperObject3=new OptionsWrapper();
             optionWrapperObject3.label=questionDetails.Option_3__c;
             optionWrapperObject3.value=questionDetails.Option_3__c;
             OptionsWrapper optionWrapperObject4=new OptionsWrapper();
             optionWrapperObject4.label=questionDetails.Option_4__c;
             optionWrapperObject4.value=questionDetails.Option_4__c;
             lstOptionWrapperObj.add(optionWrapperObject1);
             lstOptionWrapperObj.add(optionWrapperObject2);
             lstOptionWrapperObj.add(optionWrapperObject3);
             lstOptionWrapperObj.add(optionWrapperObject4);                           
             questionObject.lstOptionsWrapper=lstOptionWrapperObj;
             lstQuestionDetailsWrapper.add(questionObject);
        }
    }catch(Exception ex){
        System.debug('Exception retrieveQuestionDetails:::'+ex);
        return null;
    }
    return lstQuestionDetailsWrapper;
  }

  
  @AuraEnabled
  public static List<PerformanceList> retrievePerformanceMetrics(String strParticipantId, String strTopicId, String decScore){
      List<PerformanceList> lstPerformanceMetrics=new List<PerformanceList>();
      List<Participants__c> lstParticipants=new List<Participants__c>();
      try{
        for(Participants__c participantObj: [Select Id,Name,Participant_Score__c from Participants__c where Id=:strParticipantId]){
            participantObj.Participant_Score__c=Decimal.valueOf(decScore)+participantObj.Participant_Score__c;
            lstParticipants.add(participantObj);
        }
        if(!lstParticipants.isEmpty()){
            update lstParticipants;
        }
        Performance_Metrics__c performanceMetricObj= new Performance_Metrics__c();
        performanceMetricObj.Participant__c=strParticipantId;
        performanceMetricObj.Topic__c=strTopicId;
        performanceMetricObj.Score__c=Decimal.valueOf(decScore);
        insert performanceMetricObj;
        //Retrieving performance details
        for(Performance_Metrics__c perfObj: [Select Id, Name, Participant__r.Id, Participant__r.Name, Score__c, Topic__r.Id, Topic__r.Topic_Name__c from Performance_Metrics__c where Participant__c=:strParticipantId order by lastModifiedDate LIMIT 5 ]){
            PerformanceList perfList= new PerformanceList();
            perfList.strTopicId=perfObj.Topic__r.Id;
            perfList.strTopicName=perfObj.Topic__r.Topic_Name__c;
            perfList.strParticipantName=perfObj.Participant__r.Name;
            perfList.strParticipantId=perfObj.Participant__r.Id;
            perfList.decScore=perfObj.Score__c;
            perfList.strPerformanceId=perfObj.Id;
            lstPerformanceMetrics.add(perfList);
        }
      }catch(Exception ex){
          System.debug('Exception retrievePerformanceMetrics::'+ex);
      }
      return lstPerformanceMetrics;
  }


 public class PerformanceList {
      @AuraEnabled
      public String strTopicId {get;set;}
      @AuraEnabled
      public String strTopicName {get;set;}
      @AuraEnabled
      public String strParticipantName {get;set;}
      @AuraEnabled
      public String strParticipantId {get;set;}
      @AuraEnabled
      public Decimal decScore {get;set;}
      @AuraEnabled
      public String strPerformanceId {get;set;}
    }


  public class UserDetails {
      @AuraEnabled
      public String strUserName {get;set;}
      @AuraEnabled
      public String strUserEmail {get;set;}
      @AuraEnabled
      public Decimal strUserScore {get;set;}
      @AuraEnabled
      public String strUserId {get;set;}
  }

  public class QuestionDetailsWrapper {
      @AuraEnabled
      public String strQuestionId {get;set;}
      @AuraEnabled
      public String strQuestionName {get;set;}
      @AuraEnabled
      public String typeOfQuestions {get;set;}
      @AuraEnabled
      public String strTopicId {get;set;}
      @AuraEnabled
      public String strTopicName {get;set;}
      @AuraEnabled
      public String strTags {get;set;}
      @AuraEnabled
      public String strQuestion {get;set;}
      @AuraEnabled
      public String strExamLevelId {get;set;}
      @AuraEnabled 
      public String strExamLevelName {get;set;}  
      @AuraEnabled 
      public String strUserSelectedAnswer {get;set;}
      @AuraEnabled
      public List<OptionsWrapper> lstOptionsWrapper {get;set;} 
      @AuraEnabled
      public Boolean isCheckbox {get;set;}
      @AuraEnabled
      public String strCorrectAnswers {get;set;}
  }

  public class OptionsWrapper {
      @AuraEnabled
      public String strOption1 {get;set;}
      @AuraEnabled
      public String strOption2 {get;set;}
      @AuraEnabled
      public String strOption3 {get;set;}
      @AuraEnabled
      public String strOption4 {get;set;}
      @AuraEnabled
      public String label {get;set;}
      @AuraEnabled
      public String value {get;set;}
  }

  /*Topic Datatable Apex methods Starts*/
  @AuraEnabled
  public static List<Topic__c> retrieveTopic(){
      return [Select Id, Name, Topic_Name__c, isIntermediate__c	,isBasic__c,isAdvance__c from Topic__c];
  }
  /*Topic Datatable Apex methods Ends */
  /*Retrieving Top Performers Starts */
  
  @AuraEnabled
  public static List<Integer> retrieveTopPerformerWrapper(String strTopicId){
      System.debug('Topic Id:::'+strTopicId);
    List<Integer> lstTopPerformers= new List<Integer>();  
    try{
        AggregateResult[] groupedResult=[Select Max(Score__c)scoremax, Participant__c, Participant__r.Participant_Name__c, 
                                        Topic__c, Topic__r.Topic_Name__c 
                                        from performance_metrics__c 
                                        where Topic__c=:strTopicId group by Participant__r.Participant_Name__c,Participant__c, Topic__c, Topic__r.Topic_Name__C LIMIT 5];
           System.debug('groupedResult:::'+groupedResult);
            for(AggregateResult ar:groupedResult){
                lstTopPerformers.add(Integer.valueOf(ar.get('scoremax')));
            }
        } catch(Exception ex){
          System.debug('Exception ex::::'+ex);
      }
      System.debug('lstTopPerformers:::'+lstTopPerformers);
      return lstTopPerformers;
  }
  /*Retrieving Top Performers Ends */

  @AuraEnabled
  public static List<Participants__c> getParticipants(){
      //Retriving top performers
      return [Select Id, Name, Participant_Name__c,Participant_Score__c from Participants__c order by  Participant_Score__c desc LIMIT 5];
  }
}