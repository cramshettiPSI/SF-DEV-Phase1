public with sharing class Feedque{
public String id;

    Public Feedback_questions__c feedbackquestionInput{get;set;}  
    public Application_Feedback__c appfeed1{get;set;}
    public Feedback_questions__c feedbackquestionInput1{get;set;}
    public List<Application_Feedback__c > appfeedList {get;set;}
    public List<Feedback_questions__c > FeedqueList {get;set;}
    
    public Feedque(ApexPages.StandardController controller){
 
    feedbackquestionInput = new Feedback_questions__c();
    appfeed1 = new Application_Feedback__c();
    appfeedList =new List<Application_Feedback__c>();
    Application_Feedback__c AF = new  Application_Feedback__c();   
    appfeedList.add(AF);
    
    feedbackquestionInput1 = new Feedback_questions__c();
    FeedqueList =new List<Feedback_questions__c>();
    Feedback_questions__c FQ = new  Feedback_questions__c();   
    FeedqueList.add(FQ);
    
    
    
    //Id id = controller.getId();
    id =Apexpages.currentPage().getParameters().get('id');
    If(id!=null && id!='')
    appfeed1 =[SELECT Application__c,Name,Instructions__c,Expert_Review_Panel__c,id,Status__c from Application_Feedback__c where id =:id];
    FeedqueList  = [SELECT Question__c,Name__c,Answer__c,Scoring_Method__c,Score_number__c,Score_yes_no__c,Score_two_factor__c,Score_four_factor__c, id from Feedback_questions__c where Application_Feedback__c = :appfeed1.Id];
    }
      public PageReference Save(){
 
     PageReference Redirect;
         try{  
        
         
            Redirect = new PageReference('/apex/FeedBackQuestionDetail?id='+appfeed1.id);
            update FeedqueList;
             update appfeed1 ;
//            insert FeedqueList ;
            return Redirect;
           }
         Catch(DMLException e){
         System.debug('@@@@@@@@!!!!!'+e.getmessage());
         }
             return null;
         }         
   }