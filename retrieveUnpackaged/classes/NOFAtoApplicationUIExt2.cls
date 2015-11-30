public class NOFAtoApplicationUIExt2 
{
    Public Application3__c applicationInput{get;set;}
    Public id tempid;
    public String id;
    public String projectid; 
    public boolean isDraft{get;set;}
     Public NOFA__c Nofa{get;set;}
     Project__c pro{get;set;}
     
    public NOFAtoApplicationUIExt2 (ApexPages.StandardController controller) 
  
    {
        isDraft = false;
    applicationInput= new Application3__c();
    system.debug('params = '+Apexpages.currentPage().getParameters());
    tempid=controller.getRecord().id;
     id=Apexpages.currentPage().getParameters().get('id');
    projectid=Apexpages.currentPage().getParameters().get('projectid');
    System.debug('Valueofid'+id+'*****'+projectid);
   //  applicationInput.Project__c=projectid; 
     If(id!=null && id!='')
      Nofa=[Select ID,Allow_Concept_Paper__c,Intermediary_Justification__c,Need__c,Clarification_Summary__c,Continuation_Changes__c,VISTA_Assignment__c,Project_Name__c,Summary_of_Accomplishments__c,Leadership_and_Team__c,Cost_Effectiveness_and_Budget_Adequacy__c,Organizational_Capability__c,Executive_Summary__c,Other__c,Amendment_Justification__c,Strengthening_Communities__c,Recruitment_and_Development__c,Foster_Grandparents_Only__c,Evaluation_Summary_of_Plan__c,Standard_424__c,Program_Design__c,Program_Management__c,RSVP_Only__c from NOFA__c where id=:id];
        System.debug('Valueofid'+id+'$$$$$'+Nofa.Foster_Grandparents_Only__c);   
        applicationInput.NOFA_RFP__c=id;    
      //  applicationInput.Project__c=projectid; 
  }
   
   Public PageReference Apply(){
   projectid=applicationInput.Project__c;
   If(Nofa.Allow_Concept_Paper__c == 'Yes'){
   //    PageReference Redirect;

  //  return new Pagereference('/apex/ApplicationUI?id='+id+'&%retURL='+projectid);
     
     return new Pagereference('/apex/NOFAtoConceptPaperUI?id='+id+'&projectid='+projectid);}
     else
     {
        if(Apexpages.currentPage().getParameters().get('submittedLate')!=null){
             return new Pagereference('/apex/NOFAtoApplicationUI?id='+id+'&projectid='+projectid+'&submittedLate=Yes');
        }else{
            return new Pagereference('/apex/NOFAtoApplicationUI?id='+id+'&projectid='+projectid);
        }
     }
     
     
                  /* try{
         applicationInput.NOFA_RFP__c=id;
           
             Redirect =  new Pagereference('/apex/NOFAtoApplicationUI?addto='+id+'&%retURL='+projectid);
             
             return Redirect;
            }
      Catch(DMLException e){
          System.debug('@@@@@@@@!!!!!'+e.getmessage());
}
  */
            
            
              }
   
      
     public pagereference createProject(){
 //PageReference Redirect;
   //  User loggedinUser = [Select name,isPortalEnabled,contactid,contact.AccountId from user where id=:userinfo.getUserId()];
              // if(loggedinUser.isPortalEnabled)
     //         System.debug('$$%$%$$%$%'+contact.AccountId);
       //    pro.Organization__c = loggedinUser.contact.AccountId;
         //    PageReference pageref = new PageReference('/a0W/e?retURL=%2Fa0W%2Fo');
        //return pageref ;
      return new Pagereference('/a0W/e?retURL=%2Fa0W%2Fo');
        
    }
    public pagereference cancel(){
    
        return new Pagereference('/a0A/o');
    }
 }