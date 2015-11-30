Public Class ConceptPaperEdit{

public Application3__c applicationInput {get; set;}
public Boolean displayMsg{get;set;}
public String id;
public Boolean fieldSet1Visibility {get; set;}
public Boolean fieldSet2Visibility {get; set;}
public Boolean fieldSet3Visibility {get; set;}
public string productType {get;set;}
public list<selectOption> availableList {get;set;}     
public list<selectOption> chosenList {get;set;}

public list<Application3__c> typeOfProduct {get; set;}

Public ConceptPaperEdit(ApexPages.StandardController controller){
  applicationInput=new Application3__c();
  displayMsg=False;
  id=Apexpages.currentPage().getParameters().get('id');
 applicationInput.Status__c= null;
  If(id!=null && id!='')

  applicationInput= [Select id,Status__c,Withdraw_Justification__c,Concept_Paper_Name__c,Grantee_Status__c,NOFA_ID__c FROM Application3__c where id = :id];
  
}

    public PageReference edit() {   
    PageReference Redirect;
    If(id!=null && id!=''){
    Redirect = new PageReference('/apex/ConceptpaperEdit?id='+applicationInput.id);
    system.debug('Redirect id-->'+Redirect);
    return Redirect;
    }
    
    return null;
    }
    
    
    
    public PageReference save() {   
    PageReference Redirect;
    If(id!=null && id!=''){
    Redirect = new PageReference('/apex/ConceptPaperdetail?id='+applicationInput.id);
    applicationInput.Status__c='Submitted';
    update applicationInput;
    //return Redirect;
    }
    else
    {
    
    applicationInput.Status__c='Submitted';
    insert applicationInput;
    system.debug('record id-->'+applicationInput.id);
    
    Redirect = new   PageReference('/apex/ConceptPaperdetail?id='+applicationInput.id);
    Redirect.setRedirect(true);
    //return newpage;
    }
    return Redirect;
    }
    


    Public PageReference SaveAsDraft()
    {
          PageReference Redirect;
        If(id!=null && id!=''){
        Redirect = new PageReference('/apex/ConceptPaperdetail?id='+applicationInput.id);
        applicationInput.Status__c='--None--';      
        update applicationInput;
        System.debug('app;lication values-->'+applicationInput);
       // return Redirect;
        }
        
        else
        {

        applicationInput.Status__c='--None--';
        insert applicationInput;
        system.debug('record id-->'+applicationInput.id);

        Redirect = new   PageReference('/apex/ConceptPaperdetail?id='+applicationInput.id);
        Redirect.setRedirect(true);
        //return newpage;
        }

            
        return Redirect;
          
    }
        
      Public PageReference Reopen()
    {
        
        showPopup(); 
                  
        return null;
          
    }  
    
    Public PageReference withdrawbtn()
    {
           
        showPopup();
                   
        return null;
          
    }  
    
   // Model Pop Code Starts here
   public boolean displayPopup {get; set;}
 
    public void closePopup() {
        displayPopup = false;
    }
 
    public void showPopup() {
        displayPopup = true;
    }
    public PageReference Okbtn() {
    
        PageReference Redirect;
        If(id!=null && id!=''){
        Redirect = new PageReference('/apex/ConceptPaperdetail?id='+applicationInput.id);
        applicationInput.Status__c='Withdraw';
        update applicationInput;
        System.debug('app;lication values-->'+applicationInput);
        //return Redirect;
        }
        return Redirect;
    }
    
     public PageReference ReopenOkbtn() {
         
        PageReference Redirect;
        If(id!=null && id!=''){
        Redirect = new PageReference('/apex/ConceptpaperEdit?id='+applicationInput.id);
        applicationInput.Status__c=null;
        update applicationInput;
        System.debug('app;lication values-->'+applicationInput);
        return Redirect;
        }
            
        return null;
    }
    
    // Pop up code ends here

}