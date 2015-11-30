public with sharing class NofaSelectionCont {
    public Application3__c application{get;set;}
    public String id;
    public String parentId;    
    public NofaSelectionCont(ApexPages.StandardController controller) {
        id=Apexpages.currentPage().getParameters().get('id');
        parentId = Apexpages.currentPage().getParameters().get('parentId');
         If(id!=null && id!=''){
             application=[Select id,Match_Rate_Percentage__c,Withdraw_Justification__c,Comments__c,Legacy_App_ID__c,Application_Feedback_Summary__c,Former_SPR_Code__c, Opt_in_to_the_National_Service_Registry__c,Addendum_to__c, SPR_Code__c, If_Yes_Please_Explain_Applicant_Deliquen__c ,If_Yes_Please_Explain_EO_12372__c,Project_Priority__c, Disaster_Number_Funding_DOE__c, Partner_Project_Code__c, Team_Mobility__c, Campus__c,Other_Area_Affected_by_Project__c,Project_Director__c,Primary_State_of_Service_Activities__c,Approved_Amount__c,Executive_Officer__c,Grants_Officer__c,Senior_Grants_Officer__c,Year_of_Grant__c,Program_Officer__c,Tools_and_Equipment__c,Safety_and_Security__c,Cost_Effectiveness_and_Budget_Adequacy_C__c,If_other_please_specify_Infrastructure__c,
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
    }
    
    public PageReference continueApp(){
        update application;
        PageReference pg = new PageReference('/apex/ApplicationEditpage?id='+application.Id);
        pg.getParameters().put('isContinuingApp','true');
        pg.getParameters().put('parentId',parentId);
        pg.setRedirect(true);
        return pg;
    }

}