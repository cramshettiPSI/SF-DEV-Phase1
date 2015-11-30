/********************************************************************************************
Class Name: ApplicationEditpageExt
Description: An apex controller for ApplicationEditpage.
             Displaying NofatoApplicationUI page section based on Checkboxes in NOFA Setup and after edit/Reopen the application detials page 

**********************************************************************************************
Modified By:Prashant 
Modified On:8/10/2015
Purpose:Coomment
**********************************************************************************************/





Public Class ApplicationEditpageExt{

    public Application3__c applicationInput {get; set;}
    public Boolean displayMsg{get;set;}
    public String id;
    Public NOFA__c Nofa{get;set;}
    public ComponentData TargetPopulations {get;set;}
    public Boolean isContinuingApp {get;set;}

    public ApplicationEditpageExt getThis(){
     return this;
    }

    Public ApplicationEditpageExt(ApexPages.StandardController controller){
          applicationInput=new Application3__c();
          displayMsg=False;
          id=Apexpages.currentPage().getParameters().get('id'); 
          String isContinuing = apexPages.currentPage().getParameters().get('isContinuingApp');
          isContinuingApp = false; 
          if(isContinuing == 'true')
             isContinuingApp = true;          
              
          If(id!=null && id!='')
             applicationInput=[Select id,Match_Rate_Percentage__c,Withdraw_Justification__c,Comments__c,Legacy_App_ID__c,Application_Feedback_Summary__c,Former_SPR_Code__c, Opt_in_to_the_National_Service_Registry__c,Addendum_to__c, SPR_Code__c, If_Yes_Please_Explain_Applicant_Deliquen__c ,If_Yes_Please_Explain_EO_12372__c,Project_Priority__c, Disaster_Number_Funding_DOE__c, Partner_Project_Code__c, Team_Mobility__c, Campus__c,Other_Area_Affected_by_Project__c,Project_Director__c,Primary_State_of_Service_Activities__c,Approved_Amount__c,Executive_Officer__c,Grants_Officer__c,Senior_Grants_Officer__c,Year_of_Grant__c,Program_Officer__c,Tools_and_Equipment__c,Safety_and_Security__c,Cost_Effectiveness_and_Budget_Adequacy_C__c,If_other_please_specify_Infrastructure__c,
                              Infrastructure_Improvement__c,Other_Narrative__c,If_other_please_specify_Enivronment__c,Environmental_Stewardship_Conservation__c,Organizational_Capability__c,
                              If_other_please_specify_Energy__c,Energy_Conservation__c,Focus_Area__c,Otherobjectives__c,Natural_and_Other_Disasters__c,If_other_please_specify_capacity__c ,
                              If_other_please_specify_education__c ,If_other_please_specify_disaster__c,Program_Design__c ,Cost_Share__c,Need__c,VISTA_Assignment__c ,Characteristics_Priorities__c,
                              Program_Type__c,If_other_please_specify_Economic__c,AmeriCorps_logo_will_display_on_website__c,Economic_Opportunities__c,Number_of_elevator_speeches_created__c,
                              Capacity_Building__c,Number_of_members_wearing_logo_every_day__c,If_other_please_specify_Health__c,Healthy_Futures__c,If_other_please_specify_Enivironment_Ste__c,
                              Environmental_Stewardship__c,Disaster_Services__c,If_other_please_specify_Veterns__c,Education__c,Veterans_Military_Families__c,Strengthening_Communities__c,Number_of_ongoing_volunteers__c,
                              Number_of_episodic_volunteers_generated__c,Other_Revenue__c,Total_Match_Dollars__c,Private_Match__c,Local_State_Federal_Government_Match__c,Have_funding_history_with_any_CNCS_org__c,EO_12372_Process__c,
                              Counties__c,State_and_or_Territories__c,Specify_if_you_want_to_be_in_more_rounds__c,Disaster_Type__c,How_many_teams_are_being_requested__c,Select_a_round__c,Proposed_End_Date_is__c,
                              Proposed_Start_Date_is__c,Project_website_urls__c,Applicant_User__c,Assignee__c,Authorized_Representative__c,Point_of_Contact__c,Grantee_Status__c,Organization__c,Summary_of_Accomplishments__c ,
                              Intermediary_Justification__c ,Leadership_and_Team__c ,NOFA_RFP__r.Proposed_Dates__c,
                              Executive_Summary__c ,Target_Populations1__c,If_other_please_specify_Urban__c,Urban_and_Rural_Development__c,Organizational_Capacity__c, Cost_Effectiveness_and_Budget_Adequacy__c ,Clarification_Summary__c ,Continuation_Changes__c ,
                              Amendment_Justification__c,Strengthen_Communities__c ,Evaluation_Summary_or_Plan__c,Recruitment_and_Development__c  ,
                              Program_Management__c ,NOFA_RFP__c,Date_Received__c,Status__c,Type_of_Submission__c,Type_of_Application__c,
                              State_Application_Identifier__c,Option__c,Applicant_Delinquent_on_any_Federal_Debt__c,Additional_Information__c,If_Yes_provide_your_explination_here__c,
                              Review_by_State_Under_Executive_Order__c,Date_Received_by_State__c,Prefix__c,Organizational_Affiliation__c,First_Name__c,Title__c,Middle_Name__c,
                              Telephone_Number__c,Last_Name__c,Email__c,Suffix__c,Project__c,Areas_Affected_by_Project_Cities_Coutn__c,Proposed_Start_Date__c,
                              Proposed_End_Date__c,Documents_RSVP_Only__c,of_Unduplicated_Volunteers__c,Documents_Foster_Grandparents_Only__c,NOFA_RFP__r.Required__c,NOFA_RFP__r.Organization_Docs__c,NOFA_RFP__r.Review_Cycle__c FROM Application3__c where id = :id];
    }
    
    
     
    
    
     
     
     
    public PageReference edit() {                                                //Edit button logic 
        PageReference Redirect;
        If(id!=null && id!=''){
            Redirect = new PageReference('/'+id);
            update applicationInput;
            return Redirect;
        }       
        return null;
    }


   Public PageReference SaveAsDraft(){
         PageReference Redirect;      
         try{    
             update applicationInput;
             Redirect = new PageReference('/'+applicationInput.id);
             
             return Redirect;
         }
         Catch(DMLException e){
         System.debug('@@@@@@@@!!!!!'+e.getmessage());
    }
  
    return null;
         
    }

    //public PageReference save() {   
    //PageReference Redirect;
    //If(id!=null && id!=''){
    //Redirect = new PageReference('/'+id);
    //update applicationInput;
    //return Redirect;
    //}
    //return null;
    //}

    public PageReference save1(){
 
        string RequiredDocs;          
        map<String,Boolean> checkRequiredNarrativeFields = new map<String,Boolean>();        
        PageReference Redirect;
        try{
            if(!validate())
                return null;             
               
            checkRequiredNarrativeFields = ApplicationCheck.checkNarrativeFields(applicationInput,applicationInput.NOFA_RFP__c);
                
            if(checkRequiredNarrativeFields.size()>0){
                    string fieldNames = '';
                    for(String fieldName: checkRequiredNarrativeFields.keyset()){
                      fieldNames += fieldName +', ';
                    }
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application cannot be Submitted, Due to the following reason: Please enter values for Narrative fields: '+fieldNames));                    
                    return null;
            }
               
            RequiredDocs = checkRequiredDocsAttached();
        
            if(RequiredDocs != null  && RequiredDocs != ''){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application cannot be Submitted, Due to the following reason: Required Document not attached to Application: '+RequiredDocs));
                    return null;
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
                
            Redirect = new PageReference('/'+applicationInput.id);
            return Redirect;
          }
          Catch(DMLException e){
             System.debug('@@@@@@@@!!!!!'+e.getmessage());
          }
             return null;
    }

    public boolean Validate()                                                                               //Required filed method for save as draft
    {
        if((applicationInput.Proposed_End_Date_is__c==null ||applicationInput.Proposed_Start_Date_is__c==null) &&(applicationInput.NOFA_RFP__r.Proposed_Dates__c!=True)) 
        {
           applicationInput.Proposed_End_Date_is__c.addError('');
           applicationInput.Proposed_Start_Date_is__c.addError('');
      /*   applicationInput.Proposed_Start_Date__c.addError('');
           applicationInput.Proposed_End_Date__c.addError('');
           applicationInput.AmeriCorps_logo_will_display_on_website__c.addError('');
           applicationInput.Number_of_elevator_speeches_created__c.addError('');
           applicationInput.Number_of_episodic_volunteers_generated__c.addError('');
           applicationInput.Total_Match_Dollars__c.addError('');
           applicationInput.Private_Match__c.addError('');
           applicationInput.Local_State_Federal_Government_Match__c.addError('');
           applicationInput.Other_Revenue__c.addError('');
           applicationInput.Number_of_ongoing_volunteers__c.addError('');
           applicationInput.Number_of_members_wearing_logo_every_day__c.addError('');
           applicationInput.Counties__c.addError('');
           applicationInput.State_and_or_Territories__c.addError('');
           applicationInput.Other_Area_Affected_by_Project__c.addError('');
           applicationInput.How_many_teams_are_being_requested__c.addError('');
           applicationInput.Primary_State_of_Service_Activities__c.addError('');
           applicationInput.Select_a_round__c.addError('');
           applicationInput.Specify_if_you_want_to_be_in_more_rounds__c.addError('');*/
              
           return false;  
         }
 
    else
           return true;
    }
     
     public string checkRequiredDocsAttached(){
        
        boolean check = true; 
        string requiredDocs = '';
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
     
     public PageReference cancel(){
     	PageReference pg; 
     	system.debug('isContinuingApp = '+isContinuingApp);
     	if(isContinuingApp){
     		delete applicationInput;
     		pg = new PageReference('/'+Apexpages.currentPage().getParameters().get('parentId'));
     	}else{
     		system.debug('got here 2');
     	    pg = new PageReference('/'+applicationInput.Id);  
     	}  		     	
     	pg.setRedirect(true);
     	return pg;
     	
     }
 
}