trigger CreateAwardReportfromAward on Award__c (after Insert) {
//id for recordtype
Id FFRRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Federal Financial Reports').getRecordTypeId();
system.debug('@@@@'+FFRRecordTypeId);
Id VISTAPRSRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('VISTA Progress Report Supplements').getRecordTypeId();
Id SCPRSRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Senior Corps Progress Report Supplements').getRecordTypeId();
Id PRRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Progress Reports').getRecordTypeId();
Id EIRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Equipment Inventory').getRecordTypeId();
Id SCRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Subgrantee Certification').getRecordTypeId();
Id IURSRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Inventory of Unused or Residual Supplies').getRecordTypeId();
Id FFPRSPRRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('FGP/FGPF Progress Report Supplement').getRecordTypeId();
Id RSPVPRSRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('RSVP Progress Report Supplement').getRecordTypeId();
//list of record in Award Report 
List<Award_Reporting__c> newAwardReport =new List<Award_Reporting__c>();
List<ID> idList = new List<ID>();
set<Id> goIds = new set<Id>();
for(Award__c awards:Trigger.new){
idList.add(awards.id);
goIds.add(awards.Grants_Officer__c);
}
map<Id,User> userMap = new map<Id,User>([Select Id,Email from User where Id in :goIds]);
Map<ID,ID> award_Map = new Map<ID,ID>();
List<ID> nofaID_List = new List<ID>();
 For(Award__c aw : [Select Application_ID__r.NOFA_RFP__r.id from Award__c where id IN: idList])
{
nofaID_List.add(aw.Application_ID__r.NOFA_RFP__r.id);
award_Map.put(aw.id,aw.Application_ID__r.NOFA_RFP__r.id);
}

List<Action_Reports__c> ar_List = [Select Due_Date__c,Report_Activity__c,Reporting_Period_End_Date__c,Reporting_Period_Start_Date__c,NOFA_ID__c from Action_Reports__c where NOFA_ID__c IN: nofaID_List];

for(Award__c awards:Trigger.new){
//if (awards.RecordTypeId == VISTAPRSRecordTypeId) 

for(Action_Reports__c aw:ar_List){
Award_Reporting__c Awardreport=New Award_Reporting__c();
if(aw.Report_Activity__c=='FFR'){
Awardreport.recordtypeid=FFRRecordTypeId;
Awardreport.Due_Date__c=aw.Due_Date__c;
//Awardreport.Reporting_Start_Date__c=aw.Report_Period_Starting_Date__c;
Awardreport.Award__c=awards.id;}
else if(aw.Report_Activity__c=='FSR'){
Awardreport.recordtypeid=PRRecordTypeId;
Awardreport.Due_Date__c=aw.Due_Date__c;
Awardreport.Award__c=awards.id;}
else if(aw.Report_Activity__c=='Equipment Inventory'){
Awardreport.recordtypeid=EIRecordTypeId;
Awardreport.Due_Date__c=aw.Due_Date__c;
Awardreport.Award__c=awards.id;}
else if(aw.Report_Activity__c=='Senior Corps Progress Report Supplements'){
Awardreport.recordtypeid=SCPRSRecordTypeId;
Awardreport.Due_Date__c=aw.Due_Date__c;
Awardreport.Award__c=awards.id;}
else if(aw.Report_Activity__c=='Subgrantee Certification'){
Awardreport.recordtypeid=SCRecordTypeId;
Awardreport.Due_Date__c=aw.Due_Date__c;
Awardreport.Award__c=awards.id;}
else if(aw.Report_Activity__c=='Federal Financial Reports'){
Awardreport.recordtypeid=FFRRecordTypeId;
Awardreport.Grant_Number__c=String.valueOf(awards.Grant_Number__c);
AwardReport.Reporting_End_Date__c = aw.Reporting_Period_End_Date__c;
AwardReport.GO_Email__c = userMap.get(awards.Grants_Officer__c).Email;
Awardreport.Due_Date__c=aw.Due_Date__c;
Awardreport.Award__c=awards.id;}
else if(aw.Report_Activity__c=='VISTA PRS'){
Awardreport.recordtypeid=VISTAPRSRecordTypeId;
Awardreport.Due_Date__c=aw.Due_Date__c;
Awardreport.Award__c=awards.id;}
else if(aw.Report_Activity__c=='FGP/FGPF PRS'){
Awardreport.recordtypeid=FFPRSPRRecordTypeId;
Awardreport.Due_Date__c=aw.Due_Date__c;
Awardreport.Award__c=awards.id;}
else if(aw.Report_Activity__c=='RSVP PRS'){
Awardreport.recordtypeid=RSPVPRSRecordTypeId ;
Awardreport.Due_Date__c=aw.Due_Date__c;
Awardreport.Award__c=awards.id;}
else if(aw.Report_Activity__c=='Progress Reports' ||aw.Report_Activity__c=='Progress Report Annual'||aw.Report_Activity__c=='Progress Report Lite'||aw.Report_Activity__c=='Progress Report Lite Quarterly'||aw.Report_Activity__c=='Progress Report Lite Semiannual'){
Awardreport.recordtypeid=PRRecordTypeId ;
Awardreport.Due_Date__c=aw.Due_Date__c;
Awardreport.Award__c=awards.id;}
else if(aw.Report_Activity__c=='Inventory of Unused or Residual Supplies'){
Awardreport.recordtypeid=IURSRecordTypeId;
Awardreport.Due_Date__c=aw.Due_Date__c;
Awardreport.Award__c=awards.id;}
else{
Awardreport.Award__c=awards.id;}
newAwardReport.add(Awardreport);

   }
}

if(newAwardReport.size()>0)
   insert newAwardReport;
system.debug('@@@@'+newAwardReport);
}