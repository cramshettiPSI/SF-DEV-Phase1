public with sharing class ContactCreateControllernew {

 

    public ContactCreateControllernew (ApexPages.StandardController controller) {
        acc = new account();
        con = new contact();
        opp = new Opportunity();
        
         attach = new Attachment();
         
    }


 public ID acctID{get;set;}
 public string lastname{get;set;}
 public account acc{get;set;}
 public contact con{get;set;}
 public Opportunity opp{get;set;}
 public string accname{get;set;}
 public Attachment attach{get; set;}  
  
 
 public List<Attachment> attachList {get; set;}
// Public Attachment myfile;
 
 /*Public Attachment getmyfile()   
  {
           myfile = new Attachment();    
           return myfile;    
  } */  
 
   public pagereference save(){
       
        insert acc;
        con.accountid = acc.id;
        system.debug('account id-->'+con.accountid);
        insert con;

        opp.AccountId = acc.id;
        system.debug('account id-->'+opp.accountid);        
        insert opp;
         
       
       
        attachList = new List<Attachment>();       
        attachList.add(new Attachment(parentId = con.id, name= attach.name, body= attach.body));
        insert attachList;
        System.debug('attachList list @@@@@@@'+attachList);
       // pagereference pr = new pagereference('/'+acc.id);
        return null;
       
   }
   
}