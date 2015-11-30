public with sharing class AccountCreateController1 {
  private Application3__c app;
  public ID accId;
  public   Application3__c  acc {
    get;
    set;
  }

  public AccountCreateController1(ApexPages.StandardController controller) {
    acc = new Application3__c();
    this.app = (Application3__c) controller.getRecord();
    if (ApexPages.currentPage().getParameters().get('accId') != NULL) {
        accId = ApexPages.currentPage().getParameters().get('accId');
    }
    if (accId != NULL) {
        acc = [SELECT ID, Name from Application3__c where id = : accId];
    }
  }

  // the account record you are adding values to
  public Application3__c account {
    get {
        if (account == null)
            account = new Application3__c();
        return account;
    }
    set;
  }

  public AccountCreateController1() {
    // blank constructor
  }

  // save button is clicked
  public PageReference Apply(){
    try {
        insert account; // 
        PageReference newocp = new PageReference('/apex/ApplicationUI?retURL=%2Fa0V%2Fo&RecordType=012r00000004IJ5?Project__c='+Project__c.Name);
        newocp.setRedirect(true);
        return newocp;
    } catch (DMLException e) {
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error creating new account.'));
        return null;
    }

    return null;
  }
  
    public pagereference cancel(){
    
        return new Pagereference('/a0A/o');
    }
    public pagereference createProject(){
        return new Pagereference('/a0W/e?retURL=%2Fa0W%2Fo');
        
    }
}