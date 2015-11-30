public class Draft1 
{
    Public Application3__c applicationInput{get;set;}
    Public Id tempid;
    public boolean isDraft{get;set;}
    public Draft1 (ApexPages.StandardController controller) 
    {
        isDraft = false;
    applicationInput= new Application3__c();
    tempid=controller.getRecord().id;
    
    }
   Public PageReference SaveAsDraft(){
     //account.Draft__c='true';
     isDraft = true;
     
         try{
             upsert applicationInput;
             PageReference pg = new ApexPages.StandardController(applicationInput).view();
             pg.setRedirect(true);
             return pg;
            }
         Catch(DMLException e){
             return null;
         }
        
       }
   public PageReference MainSave(){
   
     applicationInput.Draft__c='False';
         try{
             if(!validate())
             return null;
             else
             {upsert applicationInput;
             PageReference pg = new ApexPages.StandardController(applicationInput).view();
             pg.setRedirect(true);
             return pg;
           }}
         Catch(DMLException e){
             return null;
         }
    
     }
     
     public boolean Validate()
     {
             if(applicationInput.Prefix__c == null || applicationInput.Prefix__c=='') 
         {
             applicationInput.Prefix__c.addError('You must enter Prefix');
           
             return false;
         }
         else
            return true;
     }
}