Public Class Withdrawapplicationtest{
public Application3__c applicationInput {get; set;}
//Public Status__c opt{get; set;}
public String id;
public string Withdrawapp {get;set;}

Public Withdrawapplicationtest(ApexPages.StandardController controller){
applicationInput=new Application3__c();
 applicationInput = (Application3__c)controller.getRecord();
 id=Apexpages.currentPage().getParameters().get('id');
  If(id!=null && id!='')
  applicationInput= [Select id,Need1__c,Organizational_Capacity__c ,Strengthen_Communities__c ,Evaluation_Summary_or_Plan__c ,Program_Management__c,Intermediary_Justification__c,Need__c,Clarification_Summary__c,Continuation_Changes__c,VISTA_Assignment__c,Summary_of_Accomplishments__c,Other_Area_Affected_by_Project__c,Leadership_and_Team__c,Cost_Effectiveness_and_Budget_Adequacy__c,Executive_Summary__c,Amendment_Justification__c,Strengthening_Communities__c,Recruitment_and_Development__c,Withdraw_Justification__c,NOFA_RFP__c,Date_Received__c,Status__c,Type_of_Submission__c,Type_of_Application__c,State_Application_Identifier__c,Option__c,Applicant_Delinquent_on_any_Federal_Debt__c,Additional_Information__c,If_Yes_provide_your_explination_here__c,Review_by_State_Under_Executive_Order__c,Date_Received_by_State__c,Prefix__c,Organizational_Affiliation__c,First_Name__c,Title__c,Middle_Name__c,Telephone_Number__c,Last_Name__c,Email__c,Suffix__c,Project__c,Areas_Affected_by_Project_Cities_Coutn__c,Proposed_Start_Date__c,Proposed_End_Date__c,Documents_RSVP_Only__c,of_Unduplicated_Volunteers__c,Documents_Foster_Grandparents_Only__c FROM Application3__c where id = :id]; 
}
public PageReference reopen() {   
 System.debug('Prashant#########'+Withdrawapp);
 applicationInput.Status__c = 'None';
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/'+id+'/e?retURL=%2Fa'+id);
update applicationInput;
return Redirect;
}

return null;
}
public PageReference withdraw1() {
applicationInput.Status__c='Withdraw';


return null;
}}