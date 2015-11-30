public class SaveDraft {
   Public Application3__c application {get;set;}
  Public Id tempid;
  public boolean isSaveDraft{get;set;}
    public SaveDraft (ApexPages.StandardController controller) {
    isSaveDraft = False;
    application= new Application3__c();
    tempid=controller.getRecord().id;
    System.debug('vijay id'+tempid);
   
   
   //if(tempid !=null){
    //Application3__c Temp = [SELECT Id, Type_of_Applicant__c, of_bathrooms__c, Draft__c FROM Application3__c Where Id=:tempid Limit 1];
    // application=Temp;   
     //}            
    
        
    
    }     
    
   
   Public PageReference SaveAsDraft()
   {
     application.Draft__c='true';
     
         try{
             
insert application;
             PageReference pg = new ApexPages.StandardController(application).view();
             pg.setRedirect(true);
             return pg;
            }
         Catch(DMLException e){
             return null;
         }
         
       }
   public PageReference Save(){
   
     application.Draft__c='False';
         try{
             upsert application;
             PageReference pg = new ApexPages.StandardController(application).view();
             pg.setRedirect(true);
             return pg;
           }
         Catch(DMLException e){
             return null;
         }
    
     }
}