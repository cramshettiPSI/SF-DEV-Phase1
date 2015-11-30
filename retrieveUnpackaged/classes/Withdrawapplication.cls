/********************************************************************************************
Class Name: Withdrawapplication
Description: An apex controller for ApplicationDetailpage.
             Displaying NofatoApplicationUI page section based on Checkboxes in NOFA Setup

**********************************************************************************************
Modified By:Prashant 
Modified On:8/10/2015
Purpose:Coomment
**********************************************************************************************/


Public Class Withdrawapplication{
public Application3__c applicationInput {get; set;}
//Public Status__c opt{get; set;}
public String id;
public string Withdrawapp {get;set;}
public list<Attachment__c> documents{get;set;}
public String childobjecttypes;
//public String queryString {get;set;}
//private ApexPages.StandardController controller;
public boolean RecAwardsView{get;set;}
Public Withdrawapplication(ApexPages.StandardController controller){
applicationInput=new Application3__c();
 
 applicationInput = (Application3__c)controller.getRecord();
 id=Apexpages.currentPage().getParameters().get('id');
  If(id!=null && id!='')
              applicationInput= [Select id,NOFA_RFP__r.Other_NCCC_CP__c,Withdraw_Justification__c,NOFA_RFP__r.Standard_CP__c,City__c,Legacy_App_ID__c,Project_Directorss__c,Subject_to_FAPIIS_Review__c ,Date_FAPIIS_Review__c,Mitigating_Circumstances__c,FAPIIS_Review_Comments__c,Information_available_FAPIIS_Review__c,Satisfactory_Record_Executing_Programs__c,Demonstrates_Ethics_Integrity__c,Corporate_Program__c,Application_Feedback_Summary__c,Energy_Efficiency_CP__c, Other_Energy_Efficiency_CP__c,If_Yes_Please_Explain_Applicant_Deliquen__c ,Opt_in_to_the_National_Service_Registry__c,If_Yes_Please_Explain_EO_12372__c ,Former_SPR_Code__c, Addendum_to__c, SPR_Code__c,Project_Priority__c, Disaster_Number_Funding_DOE__c, Partner_Project_Code__c, Team_Mobility__c, Campus__c,Primary_State_of_Service_Activities__c,Approved_Amount__c,Executive_Officer__c,Grants_Officer__c,Senior_Grants_Officer__c,Year_of_Grant__c,Program_Officer__c,Tools_and_Equipment__c,Safety_and_Security__c,Other_Area_Affected_by_Project__c,Cost_Effectiveness_and_Budget_Adequacy_C__c,If_other_please_specify_capacity__c,Other_Narrative__c,Name,
              If_other_please_specify_disaster__c,Other_Application_Organization__c,Target_Populations1__c,NOFA_RFP_Summary__c,Focus_Area__c,If_other_please_specify_education__c,RecordTypeid,Education__c,
              Characteristics_Priorities__c,Cost_Share__c,If_other_please_specify_Economic__c,Economic_Opportunities__c,If_other_please_specify_Health__c,Capacity_Building__c,Healthy_Futures__c,If_other_please_specify_Enivironment_Ste__c,
              Environmental_Stewardship__c,Disaster_Services__c,If_other_please_specify_Veterns__c,Veterans_Military_Families__c,AmeriCorps_logo_will_display_on_website__c,Number_of_elevator_speeches_created__c,
              Number_of_members_wearing_logo_every_day__c,Other_Revenue__c,Number_of_ongoing_volunteers__c,Number_of_episodic_volunteers_generated__c,Total_Match_Dollars__c,Private_Match__c,Local_State_Federal_Government_Match__c,
              EO_12372_Process__c,Authorized_Representative__c,Point_of_Contact__c,Counties__c,State_and_or_Territories__c,Specify_if_you_want_to_be_in_more_rounds__c,Select_a_round__c,Disaster_Type__c,How_many_teams_are_being_requested__c,
              Proposed_End_Date_is__c,Proposed_Start_Date_is__c,Project_website_urls__c,Applicant_User__c,Organization__c,Assignee__c,Grantee_Status__c,Have_funding_history_with_any_CNCS_org__c,How_many_teams_are_being_requested_CP__c,
              Number_of_teams_to_complete_this_proj_CP__c,Specify_if_you_want_to_be_in_more_rou_CP__c,Disaster_Type_CP__c,Education_CP__c,Other_Education_CP__c ,
              Veterans_and_Military_Families_CP__c,Disaster_Services_CP__c,Infrastructure_Improvement__c,If_other_please_specify_Enivronment__c,Healthy_Futures_CP__c,Environment_Stewardship_CP__c,Capacity_Building_CP__c,
              Economic_Opportunities_CP__c,Target_Populations_CP__c,Need1__c,Program_Design__c ,Organizational_Capacity__c ,Strengthen_Communities__c,Evaluation_Summary_or_Plan__c ,Program_Management__c,
              Intermediary_Justification__c,Need__c,Clarification_Summary__c,Continuation_Changes__c,VISTA_Assignment__c,Summary_of_Accomplishments__c,Leadership_and_Team__c,Cost_Effectiveness_and_Budget_Adequacy__c,
              Organizational_Capability__c,Executive_Summary__c,Other__c,Amendment_Justification__c,Strengthening_Communities__c,Recruitment_and_Development__c,NOFA_RFP__c,Date_Received__c,Status__c,
              Type_of_Submission__c,Type_of_Application__c,State_Application_Identifier__c,Option__c,Applicant_Delinquent_on_any_Federal_Debt__c,Additional_Information__c,If_Yes_provide_your_explination_here__c,
              Review_by_State_Under_Executive_Order__c,Date_Received_by_State__c,Prefix__c,Organizational_Affiliation__c,First_Name__c,Title__c,Middle_Name__c,Telephone_Number__c,Last_Name__c,Email__c,Suffix__c,Project__c,
              Areas_Affected_by_Project_Cities_Coutn__c,Proposed_Start_Date__c,Proposed_End_Date__c,Documents_RSVP_Only__c,of_Unduplicated_Volunteers__c,Documents_Foster_Grandparents_Only__c,
              Other_Veterans_and_Military_Families_CP__c,If_other_please_specify_Infrastructure__c,Comments__c,
              Program_Type__c,If_other_please_specify_Energy__c,Environmental_Stewardship_Conservation__c, Otherobjectives__c,Energy_Conservation__c,Natural_and_Other_Disasters__c,Other_Disaster_Services_CP__c,
              Other_Healthy_Futures_CP__c,Other_Environment_Stewardship_CP__c,Other_Capacity_Building_CP__c,Other_Economic_Opportunities_CP__c,Natural_and_Other_Disasters_CP__c,Other_Natural_and_Other_Disasters_CP__c,
              Other_Environmental_Steward_Conserv_CP__c,Environmental_Stewardship_Conservation_C__c,Energy_Conservation_CP__c,Other_Energy_Conservation_CP__c,Infrastructure_Improvement_CP__c,Urban_and_Rural_Development_CP__c,
              NOFA_RFP__r.Focus_Areas_and_Objectives_NCCC_CP__c,Other_Infrastructure_Improvement_CP__c,Reject_Comments__c,
              Other_Urban_and_Rural_Development_CP__c,Urban_and_Rural_Development__c,If_other_please_specify_Urban__c,NOFA_RFP__r.Required__c,NOFA_RFP__r.Organization_Docs__c,Submitted_By__c,NOFA_RFP__r.Review_Cycle__c,
              Submitted_Late__c,Late_Submission_Justification__c,Senior_Program_Officer__c,Program_Office_Director__c,Ex_Officer_Cost_Share__c,Recommended_Award_Amount__c,Total_Recommended_MSYs__c,Issue_Area__c,Staff_Decision_Comments__c,
              Red_Flag_Count__c,Red_Flags__c,CreatedById,NOFA_RFP__r.CNCS_Corporate_Program__r.Name,Organization__r.DUNS__C  FROM Application3__c where id = :id]; 

              
              
            /* if(applicationInput.Program_Officer__c!=null && applicationInput.Program_Officer__c!='')
              RecAwardsView =true;
             else*/
             RecAwardsView =false;
}
public PageReference reopen1() {   
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/apex/ConceptpaperEdit?id='+applicationInput.id);
applicationInput.Grantee_Status__c='None';
update applicationInput;
return Redirect;
}

return null;
}



public PageReference reopen() {                                 // Logic for repopn button on Application detial page and status getting changed to 'None' and redirecting to application edot page 
 System.debug('Prashant#########'+Withdrawapp);
 
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/'+id+'/e?retURL=%2F'+id);
 applicationInput.Grantee_Status__c='None';
update applicationInput;
return Redirect;
}

return null;
}

public PageReference reopenIntent() {                            // Logic for repopn button on Application detial page and status getting changed to 'None'
 System.debug('Prashant#########'+Withdrawapp);
 applicationInput.Status__c = 'None';
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/apex/NotificationEditpage?id='+applicationInput.id);
update applicationInput;
return Redirect;
}

return null;
}

public PageReference withdrawfunc(){   
 System.debug('Prashant&&&&&&&&&&&&&&&');
 applicationInput.Status__c = 'Withdrawn';
 applicationInput.Grantee_Status__c = 'Withdrawn';
applicationInput.Withdraw_Justification__c = Withdrawapp;
PageReference Redirect;
//If(id!=null && id!=''){
//system.debug('Id = '+id);
Redirect = new PageReference('/_ui/core/email/author/EmailAuthor?&template_id=00Xr0000000LxBA&p2_lkid='+applicationinput.Email__c+'&p3_lkid='+applicationInput.id);
update applicationInput;
return Redirect;
//}

//return null;
}

/* Approved for Award - 10.2.15. KY
public PageReference ApprovedforAward(){    
 applicationInput.Status__c = 'Accepted'; 
PageReference Redirect;
If(id!=null && id!='')
// system.debug('Id = '+id);
insert applicationInput;
Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);

return Redirect;

//return null;
}*/
 
 public PageReference Approve() { 
                                                     //  // Logic for Approve button on Application detial page and user redirected to Standrad event page/Email template 
    System.debug('Prashant#########'+Withdrawapp+'&&&'+applicationInput.id);
    Profile stateCommisionProfile = [Select Id from Profile where Name = 'State Commission Profile' limit 1]; 
    PageReference Redirect;
    String tmpName = 'Concept_Paper_Approved';
    String status = 'Accepted';
    If(id!=null && id!=''){
        //Redirect = new PageReference('/_ui/core/email/author/EmailAuthor?&template_id=00Xr0000000Lwek&p2_lkid='+applicationinput.Email__c+'&p3_lkid='+applicationInput.id);
        Redirect = new PageReference('/'+id);       
        if(applicationInput.Grantee_Status__c == 'Accepted'){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Concept Paper is already Approved'));
             return null;
        }       
        //update applicationInput;        
        list<User> submittedBy = new list<User>();  
        if(applicationInput.CreatedById!=null){             
                /*Integer i = applicationInput.Submitted_By__c.indexOf(' ');
                String lName = applicationInput.Submitted_By__c.left(i);            
                String fName = applicationInput.Submitted_By__c.right(applicationInput.Submitted_By__c.length()-(i+1));  */                     
                submittedBy = [Select Id,Email from User where Id = :applicationInput.CreatedById limit 1];
                 if(submittedBy.size()>0){ 
                    if(UserInfo.getProfileId()==stateCommisionProfile.Id){
                        Redirect = new PageReference('/apex/statecommission/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                    }else{
                        Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                    }                     
                 }
        }           
        return Redirect;
    }
    return null;


 }
 public PageReference Approve1() {   
  applicationInput.Grantee_Status__c = 'Accepted';
 applicationInput.Status__c = 'Accepted';
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/'+id);
update applicationInput;
return Redirect;
}

return null;
}
 public PageReference OnHold() {
                  
       
    Profile stateCommisionProfile = [Select Id from Profile where Name = 'State Commission Profile' limit 1]; 
    PageReference Redirect;
    String tmpName = 'Hold_Pending_Resources_Email';
    String status = 'On Hold Pending Resources';
    If(id!=null && id!=''){
        //Redirect = new PageReference('/_ui/core/email/author/EmailAuthor?&template_id=00Xr0000000Lwek&p2_lkid='+applicationinput.Email__c+'&p3_lkid='+applicationInput.id);
        Redirect = new PageReference('/'+id);       
        if(applicationInput.Grantee_Status__c == 'On Hold Pending Resources'){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Concept Paper is already On Hold'));
             return null;
        }      
        //update applicationInput;        
        list<User> submittedBy = new list<User>();  
        if(applicationInput.CreatedById!=null){             
                /* Integer i = applicationInput.Submitted_By__c.indexOf(' ');
                String lName = applicationInput.Submitted_By__c.left(i);            
                String fName = applicationInput.Submitted_By__c.right(applicationInput.Submitted_By__c.length()-(i+1));       */                
                submittedBy = [Select Id,Email from User where Id = :applicationInput.CreatedById limit 1]; 
                if(submittedBy.size()>0){
                    if(UserInfo.getProfileId()==stateCommisionProfile.Id){
                        Redirect = new PageReference('/apex/statecommission/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                    }else{
                        Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                    }  
                }                   
        }           
        return Redirect;
    }
    return null;                           

 }
public PageReference OnHold1() {   
 System.debug('Prashant#########'+Withdrawapp);
 applicationInput.Grantee_Status__c = 'On Hold Pending Resources';
 applicationInput.Status__c = 'On Hold Pending Resources';
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/'+id);
update applicationInput;
return Redirect;
}

return null;
}

public PageReference Reject() {
        
    Profile stateCommisionProfile = [Select Id from Profile where Name = 'State Commission Profile' limit 1]; 
    PageReference Redirect;
    String tmpName = 'Concept_Paper_Rejected_Email';
    String Status = 'Rejected';
    If(id!=null && id!=''){
        //Redirect = new PageReference('/_ui/core/email/author/EmailAuthor?&template_id=00Xr0000000Lwek&p2_lkid='+applicationinput.Email__c+'&p3_lkid='+applicationInput.id);
        Redirect = new PageReference('/'+id);       
        if(applicationInput.Grantee_Status__c == 'Rejected'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Concept Paper is already Rejected'));
            return null;
        }     
        //update applicationInput;        
        list<User> submittedBy = new list<User>();  
        if(applicationInput.CreatedById!=null){             
                /* Integer i = applicationInput.Submitted_By__c.indexOf(' ');
                String lName = applicationInput.Submitted_By__c.left(i);            
                String fName = applicationInput.Submitted_By__c.right(applicationInput.Submitted_By__c.length()-(i+1));       */                
                submittedBy = [Select Id,Email from User where Id = :applicationInput.CreatedById limit 1]; 
                if(submittedBy.size()>0){
                    if(UserInfo.getProfileId()==stateCommisionProfile.Id){                   
                        Redirect = new PageReference('/apex/statecommission/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                    }else{
                        Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                    }                     
                }
        }           
        return Redirect;
    }
    return null;

}
  public PageReference Reject1() {   
 System.debug('Prashant#########'+Withdrawapp);
 applicationInput.Grantee_Status__c = 'Rejected';
 applicationInput.Status__c = 'Rejected';
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/'+id);
update applicationInput;
return Redirect;



}

return null;
}


 public PageReference Clone1()
 {
      
 PageReference Redirect;
 Redirect = new PageReference('/apex/ClonePlus1?id='+applicationInput.Id +'&childobjecttypes=Attactment__c' + '&applicationInput.Status__c=None');
 return Redirect;
 }

 public PageReference Submitdetail() {                                                    // Logic for Submit button on Application detial page and status getting changed to 'Submittede'
    string RequiredDocs;  
     map<String,Boolean> checkRequiredNarrativeFields = new map<String,Boolean>();
    //boolean checkRequiredNarrativeFields = true;
    System.debug('Prashant#########'+Withdrawapp);
 
    PageReference Redirect;
    If(id!=null && id!=''){
        Redirect = new PageReference('/'+id);
        RequiredDocs = checkRequiredDocsAttached();       
        
        checkRequiredNarrativeFields = ApplicationCheck.checkNarrativeFields(applicationInput,applicationInput.NOFA_RFP__c);
        /*if(checkRequiredNarrativeFields == false){
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application cannot be Submitted, Due to the following reason: Please enter values for Narrative fields '));
              return null;
        }
        else*/
        
                
        if(checkRequiredNarrativeFields.size()>0){
            string fieldNames = '';
            for(String fieldName: checkRequiredNarrativeFields.keyset()){
                fieldNames += fieldName +', ';
            }
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application cannot be Submitted, Due to the following reason: Please enter values for Narrative fields: '+fieldNames));                    
            return null;
        }
        else if(checkRequiredNarrativeFields.size() == 0 && (RequiredDocs != null && RequiredDocs != '')){
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application cannot be Submitted, Due to the following reason: Required Document not attached to Application: '+RequiredDocs));
              return null;
        }else{
              system.debug('****');             
              if(applicationInput.NOFA_RFP__r.CNCS_Corporate_Program__r.Name!=null){
                    String cpName = applicationInput.NOFA_RFP__r.CNCS_Corporate_Program__r.Name;
                    if(!cpName.contains('NCCC')){
                        if(applicationInput.Organization__r.DUNS__c==null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please enter a Duns number on Organization and Submit'));
                            return null;                            
                        }   
                    }                   
              }         
              if(applicationInput.NOFA_RFP__r.Review_Cycle__c == 'Rolling'){
                applicationInput.Grantee_Status__c = 'Submitted';
                applicationInput.Status__c = 'Submitted';
              }
              else if(applicationInput.NOFA_RFP__r.Review_Cycle__c == 'Post-Deadline'){
                applicationInput.Grantee_Status__c = 'Pre - Submitted';
                applicationInput.Status__c = 'Pre - Submitted';
              }
              update applicationInput;
              
              //add attachments to organization when app is submitted      
              if(applicationInput.NOFA_RFP__r.Organization_Docs__c!=null){
                ApplicationCheck.attachOrgDocs(applicationInput, applicationInput.NOFA_RFP__r.Organization_Docs__c);
              }
        }         
    return Redirect;
    }

    return null;
}

public String checkRequiredDocsAttached(){                    //Attachment 
        
        boolean check = true; 
        string RequiredDocs = '';
        String s;
        string allAttachmentTypes='';
    
        if(applicationInput.NOFA_RFP__c!=null && applicationInput.NOFA_RFP__r.Required__c !=null){
            system.debug('boolean in !=null = '+check);
        
            s = applicationInput.NOFA_RFP__r.Required__c;
            list<String> docTypes = s.split(';');
        
        
            list<Attachment__c> attachments = new list<Attachment__c>([Select Id,Type__c from Attachment__c where Application__c = :applicationInput.Id]);
            
            if(attachments.size()>0){           
                for(Attachment__c a: attachments){              
                    if(a.Type__c!=null)
                    {   
                        allAttachmentTypes += a.Type__c+';';                    
                    }                   
                }
                system.debug('allAttachmentTypes '+allAttachmentTypes);
            }
            
            system.debug('docTypes ='+docTypes);
            for(String dType: docTypes){
                if(allAttachmentTypes!=null){
                    if(allAttachmentTypes.Contains(dType)){
                        check = true;
                    }else{
                        check = false;      
                        requiredDocs += dType + ', ';          
                    }
                }else{
                    check = false; 
                }
            }
        }
    
         return requiredDocs;
     }


 public PageReference RecomForCNCS() {
         
        PageReference Redirect;
        If(id!=null && id!=''){
        Redirect = new PageReference('/apex/CombinedDetailPage?id='+id);
        applicationInput.Status__c='Recommended for Funding';
      //  applicationInput.CNCS_Status__c='Accepted';
        update applicationInput;
        System.debug('app;lication values-->'+applicationInput);
        return Redirect;
        }
            
        return null;
    }
    
    // Add locations from Application
    public PageReference AddLocations() {
         
        PageReference Redirect;        
        Redirect = new PageReference('/apex/LocationCreationPage?applicationid='+id);     
        return Redirect;
    }
    
  /*  public PageReference saveandnew(){
    try {
        controller.save();
        
        Schema.DescribeSObjectResult describeResult = controller.getRecord().getSObjectType().getDescribe();
        
        PageReference pr = new PageReference('/' + describeResult.getKeyPrefix() + '/e?' + queryString);
        pr.setRedirect(true);
        return pr;  

    } catch(System.DMLException e) {
                return null;
    }
} */
    
    
     public PageReference HldforFormula() {
         
        PageReference Redirect;
        If(id!=null && id!=''){
        Redirect = new PageReference('/apex/CombinedDetailPage?id='+id);
        applicationInput.Status__c='Hold For Formula';
      //  applicationInput.CNCS_Status__c='Accepted';
        update applicationInput;
        System.debug('app;lication values-->'+applicationInput);
        return Redirect;
        }
            
        return null;
    }
     public PageReference Reject5() {
         
        PageReference Redirect;
        If(id!=null && id!=''){
        Redirect = new PageReference('/apex/CombinedDetailPage?id='+id);
        applicationInput.Status__c='Rejected';
       // applicationInput.CNCS_Status__c='Accepted';
        update applicationInput;
        System.debug('app;lication values-->'+applicationInput);
        return Redirect;
        }
            
        return null;
    }
    
    public pageReference returntoRework(){
        
           
        Profile stateCommisionProfile = [Select Id from Profile where Name = 'State Commission Profile' limit 1]; 
        PageReference Redirect;
        String tmpName = 'Returned_for_Rework_Email';
        String status = 'Returned for Rework';
        If(id!=null && id!=''){
            //Redirect = new PageReference('/_ui/core/email/author/EmailAuthor?&template_id=00Xr0000000Lwek&p2_lkid='+applicationinput.Email__c+'&p3_lkid='+applicationInput.id);
            Redirect = new PageReference('/'+id);       
            if(applicationInput.Grantee_Status__c == 'Returned for Rework'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Concept Paper is already Returned for Rework'));
                return null;
            }     
            //update applicationInput;        
            list<User> submittedBy = new list<User>();  
            if(applicationInput.CreatedById!=null){             
                    /*Integer i = applicationInput.Submitted_By__c.indexOf(' ');
                    String lName = applicationInput.Submitted_By__c.left(i);            
                    String fName = applicationInput.Submitted_By__c.right(applicationInput.Submitted_By__c.length()-(i+1));      */                 
                    submittedBy = [Select Id,Email from User where Id = :applicationInput.CreatedById limit 1];
                    if(submittedBy.size()>0){
                        if(UserInfo.getProfileId()==stateCommisionProfile.Id){                   
                            Redirect = new PageReference('/apex/statecommission/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                        }else{
                            Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                        }                     
                    }
            }           
        return Redirect;
        }
        return null;
        
    }
    
    // End here
    
    
    // Concept Paper Edit Button 


public boolean displayPopup {get; set;} 
    public void closePopup()
    {       
        displayPopup = false;   
    }    
    public void showPopup()
    {       
        displayPopup = true;   
    }
    
    Public PageReference ConceptContinueBtn()
    {
        PageReference Redirect;
        If(id!=null && id!=''){
        Redirect = new PageReference('/apex/ConceptpaperEdit?id='+applicationInput.id);
        applicationInput.Grantee_Status__c='Draft';
        update applicationInput;
        return Redirect;
        }

        return null;
    
    }
  // New Requirement on 4 Sep 15
  public Boolean RecAwards {get;set;}
    public PageReference RecAwardsMethod()
    {
    system.debug('recommend for award method'+applicationInput.id);   
    applicationInput.Status__c = 'Recommended For Award'; 
    upsert applicationInput;
    system.debug('upset in recommend for award method'+applicationInput);   
    PageReference Redirect;
    Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
   /* If(id!=null && id!='')
    
    {
        applicationInput.Status__c = 'Recommended For Award'; 
        upsert applicationInput;
         system.debug('upset in recommend for award method'+applicationInput);   
             
    
    }   
    */

    RecAwards = true;  
    return Redirect;
        
    }
  // End here   
   // New Requirement on 16 Oct 2015
    public PageReference saveAward(){    
    
    applicationInput.Status__c = 'Approved For Award'; 
    try 
    {
    upsert applicationInput;
    system.debug('upsert approved for award method'+applicationInput);  
    
    PageReference Redirect;
    Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
    RecAwards = false;
    /*If(id!=null && id!='')
    {
    applicationInput.Status__c = 'Approved For Award'; 
    upsert applicationInput;
     system.debug('upsert approved for award method'+applicationInput);   
    }*/
    return Redirect;
    }
    catch(Exception ex){
    ApexPages.addMessages(ex);
    }
    return null;
    }
  // End here   
    public PageReference contApp(){
    	try{
	    	Application3__c newApp = new Application3__c(); 		    	
	    	newApp = applicationInput.Clone(); 
	    	newApp.NOFA_RFP__c = null;  	
	    	//newApp.Project__c = newProj.Id;
	    	insert newApp;
	    	PageReference pg = new PageReference('/apex/NofaSelection?id='+newApp.Id);
	    	pg.getParameters().put('isContinuingApp','true');
	    	pg.getParameters().put('parentId',applicationInput.Id);
	    	pg.setRedirect(true);
	    	return pg;   
    	}
    	catch(Exception e){
    		 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to create continuing Application due to '+e));                    
             return null;
    	} 	
    	return null;
    }
    
}