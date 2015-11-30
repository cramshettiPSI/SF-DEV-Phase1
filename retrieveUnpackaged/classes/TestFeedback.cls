public class TestFeedback {
    Public Feedback_questions__c feedbackquestionInput{get;set;}   
    Public Id tempid;
    Public Stage_Question__c stagequestion {get;set;}
    public list<selectOption> availableList {get;set;}     
    public list<selectOption> chosenList {get;set;}
    Public Feedback_questions__c SQ{get;set;} 
    public List<Feedback_questions__c> FeedbackQuestionList {get;set;}
     //Public List<Feedback_questions__c> FeedbackQuestionList = new List<Feedback_questions__c>();
    public TestFeedback(ApexPages.StandardController standardController)
    {
        
    
    Id recordId = standardController.getId();
  //  List<Feedback_questions__c> FeedbackQuestionList = new List<Feedback_questions__c>();
    //Paneling__c panel = [Select Id,Name,Stage_Number__c from Paneling__c where Id = :recordId];
    // Stages__c stage = [Select Name, Id, Stage_Question1__c From Stages__c  where Id = :panel.Stage_Number__c];
    
    
    
    feedbackquestionInput = new Feedback_questions__c();
    chosenList =  new list<SelectOption>();
    tempid = standardController.getRecord().Id;
    //id=Apexpages.currentPage().getParameters().get('ID');
    System.debug('Valueofid'+tempid);
    //stagequestion =[SELECT   Active__c,Allow_Comments__c,If_Yes_Comments_Required__c,Question__c,Roles__c,Scoring_Method__c,Section__c,Weight__c 
   // from Stage_Question__c where id=:tempid];
    FeedbackQuestionList = [SELECT Id, Name, Question__c from Feedback_questions__c where Stage_Question2__c = :stagequestion.Id];                 
    }
    
   }