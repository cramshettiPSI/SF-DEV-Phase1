public class CreateContactExtns {

    public Contact Con;
    String conEmail{get;set;}
    apexpages.standardController sController;
    public CreateContactExtns(apexpages.standardController stdController){
        sController = stdController;
        this.Con = (Contact)stdController.getRecord();
        
        //conEmail =con.Email;
    }
    
    public pagereference Save(){
        pagereference pr =null;
        try{
            system.Debug('========'+con.Email);
            List<Contact> lstCon =[Select id,Email from Contact where Email =:Con.Email];
            if(lstCon!=null && lstCon.size()>0){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: The Email ID you have Entered already exists'));
            }else{
                insert con;
                pr =new pagereference('/apex/SearchOrganization');
            }
        }
        catch(exception e)
        {
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Record with this Email Exists'));
        }
        return pr;
    
    }
    
    public pagereference Cancel(){
       pagereference pr  =new pagereference('/apex/Login_Page'); 
       return pr;
    
    }
}