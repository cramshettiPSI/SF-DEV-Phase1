public class NOFAtoApplicationUIExt1 
{
    Public Application3__c applicationInput{get;set;}
    Public id tempid;
    public String id;
    public boolean isDraft{get;set;}
     Public NOFA__c Nofa{get;set;}
    public NOFAtoApplicationUIExt1 (ApexPages.StandardController controller) 
  
    {
        isDraft = false;
    applicationInput= new Application3__c();
   
    tempid=controller.getRecord().id;
     id=Apexpages.currentPage().getParameters().get('id');
    System.debug('Valueofid'+id);
     If(id!=null && id!='')
      Nofa=[Select ID,Intermediary_Justification__c,Need__c,Clarification_Summary__c,Continuation_Changes__c,VISTA_Assignment__c,Project_Name__c,Summary_of_Accomplishments__c,Leadership_and_Team__c,Cost_Effectiveness_and_Budget_Adequacy__c,Organizational_Capability__c,Executive_Summary__c,Other__c,Amendment_Justification__c,Strengthening_Communities__c,Recruitment_and_Development__c,Foster_Grandparents_Only__c,Evaluation_Summary_of_Plan__c,Standard_424__c,Program_Design__c,Program_Management__c,RSVP_Only__c from NOFA__c where id=:id];
        System.debug('Valueofid'+id+'$$$$$'+Nofa.Foster_Grandparents_Only__c);   
       // applicationInput.NOFA_RFP__c=id;     
  }
   
   Public PageReference Apply(){
     PageReference Redirect;
     
         try{
         applicationInput.NOFA_RFP__c=id;
             insert applicationInput;
             Redirect = new PageReference('/'+id);
             
             return Redirect;
            }
         Catch(DMLException e){
          System.debug('@@@@@@@@!!!!!'+e.getmessage());
}
  
return null;
         
       }
   
      
     public pagereference createProject(){
        return new Pagereference('/a0W/e?retURL=%2Fa0W%2Fo');
        
    }
    public pagereference cancel(){
    
        return new Pagereference('/a0A/o');
    }
 }