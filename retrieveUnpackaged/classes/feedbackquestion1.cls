public with sharing class feedbackquestion1
{
    private ApexPages.StandardController standardController;
 
    public feedbackquestion1(ApexPages.StandardController standardController)
    {
        this.standardController = standardController;
    }
 
    public PageReference Stagetofeedbackquestion()
    {
     PageReference pageRef = ApexPages.currentPage();
        // Apex code for handling record from a Detail page goes here
        Id recordId = standardController.getId();
    List<Feedback_questions__c> feedbackquestionInput = new List<Feedback_questions__c>();
        Stage_Question__c stagequestion =  [SELECT   Active__c,Allow_Comments__c,Question__c,Roles__c,Scoring_Method__c,Section__c,Weight__c 
                        from Stage_Question__c where Id = :recordId];
              return null;          
    }
}
     //return null;