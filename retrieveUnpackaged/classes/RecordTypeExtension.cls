Public Class RecordTypeExtension{

public List<Logic_Model__c> LogicModelLists {get; set;}  
public Application3__c applicationInput {get; set;}
public Integer size;  
Public String rectype{get;set;}
Public String rectypename{get;set;}
public Boolean displayMsg{get;set;}
public boolean isDraft{get;set;}
public String id;
Public RecordTypeExtension(ApexPages.StandardController controller){
  applicationInput=new Application3__c();
  displayMsg=False;
  LogicModelLists=new List<Logic_Model__c>();
  Logic_Model__c dummyLogicModel = new  Logic_Model__c();   
  LogicModelLists.add(dummyLogicModel); 
  rectype= Apexpages.currentPage().getParameters().get('RecordType');
   id=Apexpages.currentPage().getParameters().get('id');
  System.debug('Valueofid'+id);
  If(id!=null && id!=''){
  applicationInput=[Select recordtype.name,of_bathrooms__c,of_Members_will_wear_AC_logo_every_day__c,of_sleeping_rooms__c,of_Unduplicated_Volunteers__c,of_Unduplicated_Volunteers1__c,of_Unduplicated_Volunteers2__c,reported_in_O15_opportunity_youth__c,reported_on_O17_opportunity_youth__c,
to_create_deliver_elevator_speeches__c,of_MSY_who_are_opportunity_youth__c,Accessibility_for_Mbrs_with_Disabilities__c,Access_to_kitchen_and_meal_plan__c,AC_logo_will_display_on_org_s_website__c,Active_MOU__c,Activity__c,
Additional_Details__c,Additional_Details_vista__c,Additional_Cultural_Recreational_Educa__c,Agency_Mission__c,Amendment_Justification__c,Option__c,Any_additional_background_checks__c,Any_possible_exposure_to_safety_hazards__c,Any_potentially_hazardous_chemicals__c,Applicant__c,Applicant1__c,Applicant_Delinquent_on_any_Federal_Debt__c,
Applicant_Identifier__c,Applicant_Type__c,APPLICATION_DATE_TEST__c,Application_ID__c,Area_Code_and_Phone_Number__c,Areas_Affected_by_Project_Cities_Coutn__c,Area_type__c,Could_this_be_accomplished_with_contract__c,Contact_NumberNCCCCO__c,Certification__c,CFDA_Number__c,City__c,City1__c,CityNCCC__c,Cityhousing__c,Citylaundry__c,Cityprimary__c,
Cityprimarymailing__c,cityco__c,Clarification_Summary__c,Cleaning_Construction_Products_Used__c,Comments__c,Community_Advisory_Name_and_Addresses__c,Community_Involvement_with_Organization__c,Community_need_for_this_project__c,Competition_Identification_Number__c,Contact_Number__c,Contact_Numberprimary__c,Continuation_Changes__c,Co_Sponsoring_Agency_Information__c,Cost_Effectiveness_Budget_Adequacy__c,Cost_Share__c,
Country__c,County__c,CPR_First_Aid_Training_Details__c,Date__c,Date_Received_by_State__c,Date_Received__c,Define_Community_Need__c,Department_Name__c,Describe_Volunteer_Outreach__c,Descriptive_Title_of_Applicant_s_Project__c,Difficult_or_Uncomfortable_Conditions__c,Division_Name__c,Documents__c,Documents_Foster_Grandparents_Only__c,Documents_RSVP_Only__c,Documents_SCP_Fixed_Only__c,Documents_SCP_Only__c,
Draft__c,Email__c,Emaill__c,Email_NCCC__c,EmailNCCCCO__c,Emailprimary__c,Email_Address__c,Employer_Taxpayer_Number_EIN_TIN__c,End_Date__c,Equipment_Tools_Storage_Provided__c,Equipment_Tool_Requests_for_NCCC__c,Equipment_Tool_Safety_Hazards__c,Evaluation_Summary_or_Plan__c,Executive_Summary__c,Fax_Number__c,Fax_Number1__c,
Federal__c,Federal_Award_Identifier__c,Federal_Entity_Identifier__c,First_Name__c,First_Namee__c,Focus_Areas_and_Objectives__c,Funded_by_AC_State_National_or_VISTA__c,If_your_org_currently_funded_by_CNCS__c,
Additional_Informationcurrentlyfunded__c,Funding_Type__c,Funding_Opportunity_Title__c,Goals_Objectives_of_the_Project__c,Grant_characteristics__c,Grant_Type__c,Health_restrictions__c,
Housing_End_Date__c,Housing_Start_Date__c,Housing_Street_Address__c,Housing_Type__c,How_project_will_meet_community_needs__c,How_Will_Project_Meet_These_Needs__c,
I_Agree__c,Identify_the_pop_the_program_will_serve__c,If_Yes_provide_your_explination_here__c,If_No_please_specify__c,Additional_Information__c,Otherobjectives__c,If_yes_please_specifydiffcult__c,
If_yes_please_specifyhealthrestrictions__c,If_Yes_please_specifysecurity__c,If_Yes_please_specifyanyadditional__c,If_Yes_please_specifyanypossible__c,If_Yes_please_specifystatenationalvista__c,
Impacted_by_Inclement_Weather__c,Inclement_Weather_Work_Plan__c,Inputs__c,Intermediary_Justification__c,Introductions_of_Team_to_Sponsor_Staff__c,IRS_Certificiation_of_Non_Profit_Status__c,
Issue_Areas__c,Last_Name__c,Last_Namee__c,Laundry_Facility_Street_Address__c,Legal_Name__c,List_Emergency_facilities__c,Local__c,Local_State_Federal_Government_Match__c,
Long_term__c,Site_Mailing_Addressco__c,Mailing_Address_2__c,Mailing_Street_Addressprimary__c,Middle_Name__c,MIddle_Namee__c,Mid_Term__c,Need__c,
Negotiated_Indirect_Cost_Agreement__c,NOFA_RFP__c,NOFA_Due_Date__c,NOFA_ID__c,NOFA_Name__c,NOFA_Summary__c,Number_of_episodic_volunteers_generated__c,Number_of_ongoing_volunteers__c,
How_many_teams_are_being_requested__c,Number_of_Unduplicated_Volunteers__c,Number_of_Volunteers__c,How_many_weeks_will_it_take_to_complete__c,Objectives__c,
Site_TelephoneNCCCCO__c,Opt_in_to_the_National_Service_Registry__c,What_is_the_org_s_annual_budget__c,Organizational_Affiliation__c,Organizational_Capacity__c,Organizational_Chart__c,
Organization_Capability__c,Organization_DUNS__c,Organization_Name__c,Organization_type_Check_all_that_apply__c,Other2__c,Other_potential_safety_considerations__c,Other_Revenue__c,Other_Service_Learning_Opportunities__c,Other_Specify__c,Overview_of_your_Organization_Project__c,Personal_equipment_Clothing__c,PNS_Amendment_if_applicable__c,
PNS_Amendment_if_applicable1__c,PNS_Amendment_if_applicable3__c,Title__c,Post_Project_Maintenance_Support__c,Prefix__c,Prefixx__c,Pre_Project_Training__c,Describe_accessibility_of_the_proj_site__c,Identify_communication_access_methods__c,Private_Match__c,Problem__c,Program_Project__c,Program_Design__c,Program_Director__c,Program_Income__c,Program_Management__c,Program_Site_URL__c,Program_Type__c,Project__c,Project_Program_Title__c,Project_Activities_Outcomes__c,Project_Area_Climate_Geography__c,Project_Directors_Job_Description__c,Project_Management__c,Project_Summary_in_less_than_250_words__c,Project_Work_Plan__c,Proposed_End_Date__c,Proposed_Start_Date__c,Province__c,Publicity_of_NCCC_Partnership__c,Rationale_and_Approach__c,Received_an_AC_State_National_Grant__c,Recruitment_and_Development__c,Required_or_recommend_immunizations__c,Resources_to_pay_for_contracted_labor__c,
Review_by_State_Under_Executive_Order__c,Safety_Orientation_Training__c,Security_Safety_Med_Considerations__c,Select_priority_areas__c,Senior_Demonstration_Program_Only__c,Short_Term__c,Site_Street_AddressPrimary__c,Site_Supervisor_NameNCCC__c,Site_Supervisor_Nameprimary__c,
Site_Telephoneprimary__c,Specific_work_permits_legal_permissions__c,Start_Date__c,State__c,State1__c,State2__c,StateNCCC__c,StateLaundry__c,Stateprimary__c,Stateprimarymailing__c,Statehousing__c,Stateco__c,State_Application_Identifier__c,Station_Type__c,Status__c,Street_1__c,Street_2__c,Street_Address_Line_1__c,Street_Address_Line_2__c,Strengthen_Communities__c,Sub_Application_Due_Date__c,Sub_Grant_Type__c,Submitted_By__c,Submitted_On__c,Suffix__c,Suffixx__c,Standard_Program_Grant_Support_Grant__c,Site_Supervisor_Nameco__c,Target_Populations__c,Team_Tasks_and_Activities__c,Telephone__c,Telephone_Number__c,Telephone_Numbr__c,test__c,Titlee__c,Title_nccc__c,TitleNCCCCO__c,TitlePrimary__c,ools_Supplies_requested_from_NCCC__c,tools_Supplies_requested_from_NCCC__c,TOTAL__c,Total_Amount_Requested__c,Total_Match_Dollars__c,Tour_of_Work_Site_s_the_Community__c,Type_of_Applicant__c,Type_of_Application__c,Type_of_Submission__c,Veterans__c,VISTA_Assignment__c,Volunteers_Station_Name__c,Volunteer_Station_Supervisor_First_Name__c,Volunteer_Station_Supervisor_Last_Name__c,website__c,Weekly_Number_of_Volunteers__c,Which_State_are_you_applying_to__c,Will_service_replace_any_of_your_org_s_s__c,
Withdrawn_By__c,Withdrawn_On__c,ZipCO__c,Ziphousing__c,ZipLaundry__c,Zipprimary__c,Zipprimarymailing__c,Zip_Postal_Code__c,Zip_4__c,
Zip_Code__c from Application3__c where id=:id];

  rectypename=applicationInput.recordtype.name;
  System.debug('RecordType$$$$$$$'+rectypename);
  }
  If(rectype!=null)
  rectypename=[Select name from Recordtype where SObjectType='Application3__c' and id=:rectype].name;
  System.debug('Prashant$$$$$$$'+rectypename);
}

public PageReference addLogicModel() {    
Logic_Model__c dummyLogicModel = new  Logic_Model__c();         
LogicModelLists.add(dummyLogicModel);        
size = LogicModelLists.size();        
return null;    
}   

public PageReference save() {  
applicationInput.Grantee_Status__c='In Progress'; // the autopupulating field
PageReference Redirect;

try{
If(id!=null && id!=''){
if(!validate())
 return null;
Redirect = new PageReference('/'+id);
update applicationInput;
return Redirect;
}
else{
 if(!validate())
 return null;
applicationInput.recordtypeid=rectype;
Insert applicationInput;
Redirect = new PageReference('/'+applicationInput.id);
if(LogicModelLists.size()>0){  
  
//List<applicationLists> insertapplicationObj = new List<applicationLists>();  
For(Logic_Model__c lm:LogicModelLists){
lm.Application__c=applicationInput.id;
}
Insert LogicModelLists;
displayMsg=True; 
}
return Redirect;
}
}
catch(Exception e){
System.debug('@@@@@@@@!!!!!'+e.getmessage());
}
  
System.debug('@@@@@@@@&&&&&&'+displayMsg);
   
return null;
}
Public PageReference SaveAsDraft(){
     applicationInput.Status__c='none';
PageReference Redirect;

try{

If(id!=null && id!=''){
Redirect = new PageReference('/'+id);
update applicationInput;
return Redirect;
}

else{
applicationInput.recordtypeid=rectype;
Insert applicationInput;
Redirect = new PageReference('/'+applicationInput.id);
if(LogicModelLists.size()>0){       
//List<applicationLists> insertapplicationObj = new List<applicationLists>();  
For(Logic_Model__c lm:LogicModelLists){
lm.Application__c=applicationInput.id;
}
Insert LogicModelLists;
displayMsg=True; 
}
return Redirect;
}
}
catch(Exception e){
System.debug('@@@@@@@@!!!!!'+e.getmessage());
}
  
return null;
         
       }
       
    public boolean Validate()
     {
         if(applicationInput.Prefix__c == null || applicationInput.Prefix__c=='') 
         {
             applicationInput.Prefix__c.addError('You must enter Prefix');
           
             return false;
         }
         else if((applicationInput.Contact_NumberNCCCCO__c==null|| applicationInput.Contact_NumberNCCCCO__c=='') && rectypename=='AmeriCorps NCCC'){
           applicationInput.Contact_NumberNCCCCO__c.addError('You must enter cell number');
           return false;
           }
         else
            return true;
     }   

}