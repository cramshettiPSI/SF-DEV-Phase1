public with sharing class ContactCreateController11 {




    public ContactCreateController11(ApexPages.StandardController controller) {
    id=Apexpages.currentPage().getParameters().get('id');
        
        If(id!=null && id!='')
{
  con= [Select id,lastname,Salutation,FirstName,Middle_Name__c,Suffix__c,Primary_Phone__c,Is_this_a_Mobile_Number__c,Would_you_like_to_receive_texts__c,
OtherPhone,Email,Re_Enter_Email__c,Mailing_Street_Address_1__c,Mailing_Street_Address_2__c,Mailing_State__c,Mailing_City__c,Mailing_Zip_Code__c,
State_of_Residence__c,Gender__c,Date_of_Birth__c,Ethnicity_Type__c,Race_Type__c,How_did_you_hear_about_CNCS_Reviews__c,Please_Specify__c,Reasonable_Accommodations_Required__c,
If_Yes_describe_what_is_needed__c   FROM contact where id = :id];
  
   edu =[select id,User_Account__c,Highest_Level_of_Education__c,College_University__c ,Organization_Type__c,Degree_Earned__c,From__c,To__c,Area_s_of_Study_Degree_Details__c  from education__c where User_Account__c=:id]; 
   emp =[select id,Name ,User_Account__c,Organization_Type__c,From__c,To__c,Expertise__c,Area_of_Expertise__c,Experience_Type__c,Years_of_Experience__c,Job_Description__c  from Employment__c where User_Account__c=:id]; 
        
}        
    }
    public Application3__c applicationInput {get; set;}
public String id;    
public ID acctID{get;set;}
public ID contactID{get;set;}
public string lastname{get;set;}
public Education__C edu{get;set;}
public contact con{get;set;}
//set { con = new contact(); }}

public Employment__c emp{get;set;}
public string accname{get;set;}
public Attachment attach{get; set;}  
public List<Attachment> attachList {get; set;}
// Add more Contact to account

public Account accounts;
public Contact contacts;
public Education__c del;
public Employment__c empdel;
public boolean button_flag=false;
public boolean edubutton_flag=false;
public boolean empbutton_flag=false;
public List<Education__c> addattendeeList {get;set;}
public List<Employment__c> empaddattendeeList {get;set;}
public List<Education__c> delattendeeList {get;set;}
public List<Employment__c> empdelattendeeList {get;set;}
public List<Education__c> attendeeList {get;set;}
public List<Employment__c> empattendeeList {get;set;}
public Integer totalCount {get;set;}
public Integer totalCount1 {get;set;}
public Integer rowIndex {get;set;}
public boolean abool{get;set;}
public boolean edubool{get;set;}
public boolean empbool {get;set;}


public List<Education__c> delAttendees {get; set;} 
public List<Employment__c> empdelAttendees {get; set;} 
Public Boolean rend1{get;set;}
//Ends here

   public pagereference save(){
       
    
    
    return null;
       
   }
   
  public PageReference edit() {   
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/apex/ExpertReviewerApplication'+applicationInput.id);
update applicationInput;
return Redirect;
}

return null;
}  
 }