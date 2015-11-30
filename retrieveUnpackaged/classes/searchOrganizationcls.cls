public class searchOrganizationcls{
    public Account actobj{get;set;}
    public List<Account> accountList{get;set;}
    public integer actcount{get;set;}
    public String MyAccountId {get; set;}   
    public string userId = ApexPages.currentPage().getParameters().get('uid');
    public searchOrganizationcls(){
        accountList = new List<Account>();
        actobj = new Account();
        actcount = 0;
    }
    public void searchOrganization(){
        String query ='select id,Name,EIN__c,Legal_Name__c,First_Name__c,Address_1__c,City__c,state__c from Account where id!=null';
        if(actObj.EIN__c!=null && actObj.EIN__c!=''){
            query+=' and EIN__c=\''+actObj.EIN__c+'\'';
            accountList=database.query(query);
            if(accountList.size()==0){
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'EIN does not exist in system. Please create a new organization'));
            }
            actcount = accountList.size();
        }
        else{
            actcount = 0;
        }
        System.debug(query);
    
    }


    public pagereference choose(){
    
        Contact newContact =[Select id,AccountId from Contact where Id =:userId limit 1];
        newContact.AccountId = MyAccountId;
        update newContact;
        return new pagereference('/apex/CommunitiesSelfRegConfirm');
    }

    public pagereference registration(){
    
        return null;
    }
    public pagereference createOrganization(){
        return new Pagereference('/apex/Createorganization?uid='+userId);
    }
     public pagereference cancel(){
    
        return new Pagereference('/apex/Login_Page');
    }
    
}