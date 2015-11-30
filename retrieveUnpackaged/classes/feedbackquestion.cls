public class feedbackquestion {
    Public Feedback_questions__c feedbackquestionInput{get;set;}
    
    Public Id tempid;
  
    Public Stage_Question__c stagequestion {get;set;}
    public list<selectOption> availableList {get;set;}     
    public list<selectOption> chosenList {get;set;}
    Public Feedback_questions__c SQ{get;set;} 
    //public String Id;
    
    public feedbackquestion getThis()
    {
        return this;
    }
    
     public feedbackquestion (ApexPages.StandardController controller) 
    {
        feedbackquestionInput = new Feedback_questions__c();
       
        
        chosenList =  new list<SelectOption>();
        tempid= controller.getRecord().Id;
      // id=Apexpages.currentPage().getParameters().get('ID');
        System.debug('Valueofid'+tempid);
         stagequestion =
                        [SELECT   Active__c,Allow_Comments__c,Question__c,Roles__c,Scoring_Method__c,Section__c,Weight__c 
                        from Stage_Question__c 
                        where id=:tempid];
                     
                   
     }
    
    
}