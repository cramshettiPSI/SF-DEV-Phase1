public class FeedqueCV {
    //Get the Standard Controller
    private ApexPages.StandardController std;
     
    // the associated FeedqueList
   public List<Feedback_questions__c> FeedqueList;
      
    //Init the Class
    public FeedqueCV(ApexPages.StandardController stdCtrl)
    {
     std=stdCtrl;
    }
     
    //Get the application feedback record 
    public Application_Feedback__c getApplicationFeedback()
    {
     return (Application_Feedback__c) std.getRecord();
    }
 
    //Code to update the feedback questions
    private boolean updateFeedqueList()
    {
        boolean result=true;
        //Can't update if there is nothing in the list
        if (null!=FeedqueList)
           {

            //try catch block to update the feedback questions
              try
              {
               update FeedqueList;
              }
              catch (Exception e)
              {
                  //if it fails, let's nicely display the message
                 String msg=e.getMessage();
                 integer pos;
                  
                 // if its field validation, this will be added to the messages by default
                 if (-1==(pos=msg.indexOf('FIELD_CUSTOM_VALIDATION_EXCEPTION, ')))
                 {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, msg));
                 }
                  
                 result=false;
              }
           }
            
           return result;
    }
     
     
    public PageReference save()
    {
   
    //Assume it works
    Boolean result=true;
    //Send it back to detail page
     PageReference pr=Page.FeedBackQuestionDetail;
     //get the application feedback ID
     if (null!=getApplicationFeedback().id)
     {
        //first, update the feedback questions
      result=updateFeedqueList();
     }
     else
     {
         
      pr.setRedirect(true);
     }
      
     if (result)
     {
        // call standard save, but don't capture the return value which will redirect to view page
        std.save();
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Changes saved'));
     }
        pr.getParameters().put('id', getApplicationFeedback().id);
      
     return pr;
    }
 
     public PageReference submit()
    {
    getApplicationFeedback().Status__c = 'Submitted';
    //Assume it works
    Boolean result=true;
    //Send it back to detail page
     PageReference pr=Page.FeedBackQuestionDetail;
     //get the application feedback ID
     if (null!=getApplicationFeedback().id)
     {
        //first, update the feedback questions
      result=updateFeedqueList();
     }
     else
     {
         
      pr.setRedirect(true);
     }
      
     if (result)
     {
        // call standard save, but don't capture the return value which will redirect to view page
        std.save();
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Changes saved'));
     }
        pr.getParameters().put('id', getApplicationFeedback().id);
      
     return pr;
    }
     
   public List<Feedback_questions__c> getFeedqueList()
    {
       if ( (null!=getApplicationFeedback().id) && (FeedqueList == null) )
       {
       //get the list of feedback questions
        FeedqueList = [SELECT Question__c,Name__c,Answer__c,Scoring_Method__c,Score_number__c,Score_yes_no__c,Score_two_factor__c,Score_four_factor__c, test_score__c, id from Feedback_questions__c where Application_Feedback__c = :getApplicationFeedback().ID ORDER BY Name__c];
        
       }
                           
       return FeedqueList;
    }
}