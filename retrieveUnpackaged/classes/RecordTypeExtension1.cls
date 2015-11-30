Public Class RecordTypeExtension1{

public List<Application3__c> applicationLists {get; set;}  
public Application3__c applicationOffice {get; set;}
public Integer size;  
Public String rectype{get;set;}
Public String rectypename{get;set;}
public Boolean displayMsg{get;set;}

Public RecordTypeExtension1(ApexPages.StandardController controller){
  displayMsg=False;
  applicationLists=new List<Application3__c>();
  Application3__c dummyApplication = new  Application3__c();   
  applicationLists.add(dummyApplication); 
  rectype= Apexpages.currentPage().getParameters().get('RecordType');
  
  If(rectype!=null)
  rectypename=[Select name from Recordtype where SObjectType='Application3__c' and id=:rectype].name;
  System.debug('Prashant$$$$$$$'+rectypename);
}

public PageReference addApplication() {    
Application3__c dummyApplication = new  Application3__c();         
applicationLists.add(dummyApplication);        
size = applicationLists.size();        
return null;    
}   

public PageReference save() {   

if(applicationLists.size()>0){       
//List<applicationLists> insertapplicationObj = new List<applicationLists>();  
try{
Insert applicationLists;
}
catch(Exception e){
System.debug('@@@@@@@@!!!!!'+e.getmessage());
}
displayMsg=True;   
System.debug('@@@@@@@@&&&&&&'+displayMsg);
}   
return null;
}
public pagereference createProject(){
        return new Pagereference('/a0W/e?retURL=%2Fa0W%2Fo');
        
    }
    public pagereference cancel(){
    
        return new Pagereference('/a0A/o');
    }
    public pagereference apply(){
     
     return new Pagereference('/apex/ApplicationUI?retURL=%2Fa0V%2Fo&RecordType=012r00000004IJ5?NOFA_RFP__c={!NOFA__c.Id}&Project__c={!Project__c.Name}');
     
    }

}