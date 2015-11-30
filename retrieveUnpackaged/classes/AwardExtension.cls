Public Class AwardExtension{
public Award__c awarddetail {get; set;}
public String id;
public GroupMember gm {get;set;}
Public Boolean showPOButton{get;set;}
Public Boolean showSPOButton{get;set;}
Public Boolean showGOButton{get;set;}
Public Boolean showXOButton{get;set;}
Public Boolean showSGOButton{get;set;}
Public Boolean showEditButton{get;set;}


Public Awardextension(ApexPages.StandardController controller){
awarddetail=new Award__c();
 awarddetail = (Award__c)controller.getRecord();
 id=Apexpages.currentPage().getParameters().get('id');
String gmid = Apexpages.currentPage().getParameters().get('gmid'); 
List<String> allGroupIDs = new List<String>();
for (GroupMember gm : [SELECT Id, group.id, group.name, group.type FROM GroupMember where (UserOrGroupId = :UserInfo.getUserId() AND group.type='Regular')]){
allGroupIDs.add(gm.group.id);
system.debug('tets@@'+gm);
}
gmid=userinfo.getUserId();
  If(gmid!=null) 
 List<GroupMember> gm=[Select id,UserOrGroupId from GroupMember where UserOrGroupId=:gmid];
 System.debug('@@@groupmember'+gmid);
 //For(GroupMember m:[Select id,UserOrGroupId from GroupMember where GroupId=:gmid]){
 //System.debug('@@@groupmember'+m);
 //}
 // User loggedinUser = [Select id,name from user where id=:userinfo.getUserId()];
     //awarddetail.PO__c = loggedinUser;
 //awarddetail.PO__c= Userinfo.getUserId();
   
  If(id!=null && id!='')
  awarddetail=[select id,Name,Being_Committed__c,Organization_re_Signature__c,Application_ID__r.Organization__r.Registration_Active_until__c,Application_ID__r.Organization__r.CCR_Verified__c,Award_Flow__c,Application_ID__r.Type_of_Application__c,Max_of_sub_budgets_per_application__c,Obligated__c,eSigned__c,Awaiting_SGO_Approval__c,Match_Status__c,Sub_budgets_for_multi_year_grants__c,Budget_Period_End__c,Budget_Period_Start__c,Amendment__c,NOFA_Name__r.Cash_Grants_Awards__c,Grant_Performance_Period_Start__c,Grant_Performance_Period_End__c,Sponsor_e_Signature__c,NOFA_Name__r.Cooperative_Agreement__c ,Committed__c, Amendment_Reason__c,OwnerId,Application_ID__r.Program_Type__c,Amendment_Type__c,Application_ID__c,
  Application_ID__r.Cost_Share__c,Application_Type__c,Approved_Amount__c,Award_Description__c,Executive_Officer__c,XO_CSHR__c,Fund_Commitment_Comments__c,Grant__c,Grants_Officer__c,Grant_Status__c,NOFA_Name__c,Corporate_Program__c,CNCS_Corporate_Program__c,Organization_Legal_Name__c,
  POs__c,PO__c,PO_Certification_Date__c,PO_Comments__c,Program_Officer__c,Project_End_Date__c,Project_Name__c,Project_Start_Date__c,Senior_Grants_Officer__c,Senior_Program_Officer__c,Special_Conditions__c,SPO__c,SPO_Certification_Date__c,
  Red_Flag_Count__c, Red_Flags__c,  Year_of_Grant__c,FAPIIS_Review_Comments__c,Mitigating_Circumstances__c,Information_Available__c,Subject_to_FAPIIS_Review__c,FAPIIS_Review_Date__c,Demonstrates_Ethics_Integrity__c,Satisfactory_Record_Executing_Programs__c from Award__c where id=:id];
   
  if ((awarddetail.Grant_Status__c == 'Awaiting SPO Approval') || (awarddetail.Grant_Status__c == 'Awaiting SPO Award') ){
  awarddetail.OwnerId = awarddetail.Senior_Program_Officer__c;
  }
  else if(awarddetail.Grant_Status__c == 'Being Committed')  {
   awarddetail.OwnerId = awarddetail.Executive_Officer__c;
   }
   else if(awarddetail.Grant_Status__c == 'Awaiting GO Certification'){
   awarddetail.OwnerId = awarddetail.Grants_Officer__c;
   }
   else if(awarddetail.Grant_Status__c == 'Awaiting SGO Approval'){
   awarddetail.OwnerId = awarddetail.Senior_Grants_Officer__c;
   }   
  else if(awarddetail.Grant_Status__c == 'Awaiting XO CSHR Approval'){
   awarddetail.OwnerId = awarddetail.XO_CSHR__c;
   system.debug('@@@@@PRASS');
   } 
   else if(awarddetail.Grant_Status__c == 'Awaiting PO Certification'){
   awarddetail.OwnerId = awarddetail.Program_Officer__c;
   }  
   else
  {
awarddetail.OwnerId = awarddetail.OwnerId;
  }
  }
 //Rendering Logic----
Public void initMethod(){
  
  List<String> grouplist = new List<String>{'PO Group','GO Group','SPO Group','XO Group','SGO Group'};
  List<GroupMember> gmlist=[Select Id, UserOrGroupId, group.name From GroupMember where group.name IN: grouplist];
  showPOButton=False;
  showSPOButton=False;
  Set<String> POGroupUserlist = new Set<String>();
  Set<String> SPOGroupUserlist = new Set<String>();
  Set<String> GOGroupUserlist = new Set<String>();
  Set<String> XOGroupUserlist = new Set<String>();
  Set<String> SGOGroupUserlist = new Set<String>();
  String loggedinUserId = Userinfo.getuserid();
  
  for(groupmember gm:gmlist)
  {
    if(gm.group.name == 'PO Group')
       POGroupUserlist.add(gm.UserOrGroupid);
    if(gm.group.name == 'SPO Group')
       SPOGroupUserlist.add(gm.UserOrGroupid);  
    if(gm.group.name == 'GO Group')  
       GOGroupUserlist.add(gm.UserOrGroupid);  
    if(gm.group.name=='XO Group')
       XOGroupUserlist.add(gm.UserOrGroupid);  
    if(gm.group.name=='SGO Group')
       SGOGroupUserlist.add(gm.UserOrGroupid);  
      }   
  if( awarddetail.Ownerid==loggedinUserId)
  showEditButton=True;
  If(POGroupUserlist.contains(loggedinUserId))
  showPOButton=True;
  
  If(SPOGroupUserlist.contains(loggedinUserId))
  showSPOButton=True;
  
   If(GOGroupUserlist.contains(loggedinUserId))
   showGOButton=True;
   
    If(XOGroupUserlist.contains(loggedinUserId))
   showXOButton=True;
   
    If(SGOGroupUserlist.contains(loggedinUserId))
   showSGOButton=True;
  }
    
 
 /*Award Action  
  public PageReference AwardApp() {           
if (awarddetail.Grant_Status__c != 'Obligated' || awarddetail.Grant_Status__c != 'Awaiting SGO Award'){
  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
  return null;
}
else {
    awarddetail.Grant_Status__c='Awarded';
    }
update awarddetail;
//return Redirect;
return null;
} */

//Award Action  
  public PageReference AwardApp() {           
if ((awarddetail.Grant_Status__c == 'Obligated' && awarddetail.Sponsor_e_Signature__c==true) || (awarddetail.Grant_Status__c == 'Awaiting SGO Award' && awarddetail.Sponsor_e_Signature__c==true) || (awarddetail.Grant_Status__c == 'Obligated'&& awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='No')){
    
    awarddetail.Grant_Status__c='Awarded'; 
  update awarddetail;
}
else {
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
  
    }
return null;
}

// Certifiy Application by PO (PO, SPO) 
 public PageReference CertifiyApplicationbyPO () {    
  PageReference Redirect;
if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award". '));                    
  return null;
}
else {  
awarddetail.Grant_Status__c='Awaiting SPO Approval';
// awarddetail.PO__c= Userinfo.getUserId();
}
update awarddetail;
Redirect = new PageReference('/'+awarddetail.id);
//return Redirect;
return Redirect;
}

// Certifiy Application by SPO              
public PageReference ApproveGrantpreviouslycertifiedbyPO () {    
PageReference Redirect;
if (awarddetail.Committed__c == True ){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Approve this Award". '));                    
  return null;
}
/*else if
(awarddetail.NOFA_Name__r.Cash_Grants_Awards__c == 'Yes' && awarddetail.Application_ID__r.Cost_Share__c == 'Yes') {
awarddetail.Grant_Status__c = 'Awaiting XO CSHR Approval' ;  
             
  update awarddetail;
  Redirect = new PageReference('/'+awarddetail.id);
   system.debug('@@@@@PRASSSSSSSHANT');
  return Redirect;
} */
else if
(awarddetail.Grant_Status__c != 'Awaiting SPO Approval') {
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Approve this Award". '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Being Committed';

update awarddetail;
Redirect = new PageReference('/'+awarddetail.id);
return Redirect;
}
return null;
}

// Certify Application Previously Committed (SPO). This button works only if the Committed checkbox is checked. 
public PageReference CertifyApplicationCommitted () {  
    PageReference Redirect; 
    if (awarddetail.OwnerId != Userinfo.getUserId()){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award. '));                    
  return null;  
    } 

//if ((PRIORVALUE(awarddetail.Grant_Status__c == 'Awaiting PO Certification')))
else if (awarddetail.Committed__c == True && awarddetail.Grant_Status__c != 'Awaiting SGO Approval')

{
    awarddetail.Grant_Status__c='Awaiting GO Certification';
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
return Redirect;
}
else{
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award". '));                    
  return null;
}

}


 
 // Send to PO
 public PageReference sendtopo () {     
 if (awarddetail.OwnerId != Userinfo.getUserId()){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to PO. '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Awaiting PO Certification';}
update awarddetail;
//return Redirect;
return null;
}

// Send to SPO
public PageReference sendtospo () {     
if (awarddetail.OwnerId != Userinfo.getUserId()){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to SPO. '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Awaiting SPO Approval';}
update awarddetail;
//return Redirect;
return null;
}
 
 // Send BACK AWARD to GO - from PO, SGO
 public PageReference sendtoGO () {    // Certifiy Application by GO
if (awarddetail.OwnerId != Userinfo.getUserId() || awarddetail.Grant_Status__c!='Awaiting SGO Approval'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to GO". '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Awaiting GO Certification';}
update awarddetail;
//return Redirect;
return null;
}
 
 // Send to SGO - from GO ONLY
 
 public PageReference sendtoSGO () {    // Certifiy Application by GO 
if (awarddetail.Grant_Status__c != 'Awaiting GO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot send this Award to SGO". '));                    
  return null;
}
awarddetail.Grant_Status__c='Awaiting SGO Approval';
update awarddetail;
//return Redirect;
return null;
}


// Certify, Send to SGO
public PageReference CertifytoSGO () {    
PageReference Redirect;
if (awarddetail.Grant_Status__c != 'Awaiting GO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award". '));                    
  return null;
}
awarddetail.Grant_Status__c='Awaiting SGO Approval';
update awarddetail;
Redirect = new PageReference('/'+awarddetail.id);
return Redirect;
}



public PageReference commitfromSGO() {    

awarddetail.Grant_Status__c='Being Committed';
update awarddetail;
//return Redirect;
return null;
}
 
 
 public PageReference  Obligatepgmtypenull() {    // Obligate if Program Type null and Cash 'yes' and Cost share 'No'
if (awarddetail.Grant_Status__c == 'Awaiting SGO Approval' || awarddetail.Grant_Status__c == 'Awaiting SGO Obligation'){
awarddetail.Grant_Status__c='Obligated';
update awarddetail;
}else
{
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Obligated this Award". '));                    
  return null;
}
return null;
}
 
 public PageReference CertifiyApplicationbyPO1 () {    // Certifiy Application by PO   sendtoXO

awarddetail.Grant_Status__c='Awaiting Organization e-Signature';
// awarddetail.POs__c= Userinfo.getUserId();
//awarddetail.PO__c= gmid;
update awarddetail;
//return Redirect;
return null;
}

 //Send to XO - from GO, SGO
 public PageReference sendtoXO () {    // Certifiy Application by PO   
if (awarddetail.OwnerId != Userinfo.getUserId()){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to XO". '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Awaiting XO CSHR Approval';}
update awarddetail;
//return Redirect;
return null;
}

 //Withdraw Award - ONLY by PO. 
 public PageReference Withdraw() {            
if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Withdraw this Award". '));                    
  return null;
}
awarddetail.Grant_Status__c='Withdrawn';
update awarddetail;
//return Redirect;
return null;
}

// CSHR XO will send the Award to XO
public PageReference CSHRtoXO() {            
if (awarddetail.Grant_Status__c != 'Awaiting XO CSHR Approval'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot send this Award to XO". '));                    
  return null;
}
awarddetail.Grant_Status__c='Being Committed';
update awarddetail;
//return Redirect;
return null;
}

//Reject Award - ONLY by PO. 
 public PageReference reject() {            
if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Reject this Award". '));                    
  return null;
}
awarddetail.Grant_Status__c='Rejected';
update awarddetail;
//return Redirect;
return null;
}

//Return to Rework - ONLY by PO. 
 public PageReference ReturntoRework() {            
  PageReference Redirect;  
if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Return this Award to Rework". '));                    
  return null;
}
awarddetail.Grant_Status__c='Returned to Rework';
update awarddetail;
//return Redirect;
return null;
}

// Send BACK to XO - from GO, SGO
public PageReference returntoXO () {       
if (awarddetail.OwnerId != Userinfo.getUserId()|| awarddetail.Grant_Status__c!='Awaiting SGO Approval'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to XO". '));                    
  return null;
}
awarddetail.Grant_Status__c='Being Committed';
update awarddetail;
//return Redirect;
return null;
 }
 
 // Approve Agreement by XO
public PageReference ApproveAgreementbyXO() {  
    PageReference Redirect;     
if (awarddetail.OwnerId != Userinfo.getUserId()){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Commit the Funds". '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Awaiting GO Certification';
update awarddetail;
Redirect = new PageReference('/'+awarddetail.id);
return Redirect;
}
//return Redirect;
return null;
 }
 
 // Certify & Send to Organization for e-Signature (PO,SPO) (#2,#6-1)
public PageReference esign() {    
if (awarddetail.Grant_Status__c == 'Awaiting PO Certification' ){
awarddetail.Grant_Status__c='Awaiting Organization e-Signature';
update awarddetail;
}else
{
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot send this Award for e-Signature". '));                    
  return null;
}
return null;
}

// External user e-signs the Award 
public PageReference esignature() {    
if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.Obligated__c != true && awarddetail.Awaiting_SGO_Approval__c == true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='Yes')
{
awarddetail.Grant_Status__c='Awaiting SGO Obligation';
update awarddetail; 
}
else 
if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.Obligated__c == true && awarddetail.Awaiting_SGO_Approval__c == true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='Yes')
{
awarddetail.Grant_Status__c='Awaiting SGO Award';
update awarddetail; 
}
else if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Optional'&& awarddetail.Application_ID__r.Program_Type__c=='Standard')
{
awarddetail.Grant_Status__c='Awaiting SPO Award';
update awarddetail;
}
else if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='No')
{
awarddetail.Grant_Status__c='Awaiting SPO Award';
update awarddetail;
}
else if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true  && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Optional'){
awarddetail.Grant_Status__c='Awaiting SPO Approval';
update awarddetail;
}

else
{
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please Edit and Check "Sponsor e-Signature" before signing Agreement. '));                    
  return null;
}
return null;
}

// SPO signs the Award and Sends to XO
public PageReference esignaturebySPO() {    
if (awarddetail.Grant_Status__c == 'Awaiting SPO Approval' && awarddetail.Sponsor_e_Signature__c==true){
awarddetail.Grant_Status__c='Awaiting XO CSHR Approval';
update awarddetail;
}else
{
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot e-sign this Award. '));                    
  return null;
}
return null;
}

// Move application to next status without committing - XO moves the Award to GO for a previously committed funds
public PageReference moveWithoutCommitting() {    
if (awarddetail.Grant_Status__c == 'Awaiting XO CSHR Approval' || awarddetail.Grant_Status__c == 'Being Committed'){
awarddetail.Grant_Status__c='Awaiting GO Certification';
update awarddetail;
}else
{
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot send this Award to GO". '));                    
  return null;
}
return null;
}

// Sign and Award Agreement (#6)
public PageReference AwardnonCS() {           
if (awarddetail.Grant_Status__c != 'Awaiting SPO Award'){
  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
  return null;
}
else {
    awarddetail.Grant_Status__c='Awarded';
    }
update awarddetail;
//return Redirect;
return null;
}

// Move to Next Status without Obligating (SGO)
public PageReference MovetoAward() {           
if (awarddetail.Grant_Status__c != 'Awaiting SGO Approval'){
  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record if the Status is not "Awaiting SGO Approval". '));                    
  return null;
}
else {
    awarddetail.Grant_Status__c='Awarded';
    }
update awarddetail;
//return Redirect;
return null;
}

// Certify and Send for Organization eSignature - Sent by SGO
public PageReference eSignaturebySGO () {    
awarddetail.Grant_Status__c='Awaiting Organization e-Signature';
update awarddetail;
//return Redirect;
return null;
}


// Sign Agreement and send to XO - SPO Action
public PageReference SignAgreementtoXO () { 
PageReference Redirect;
awarddetail.Grant_Status__c='Being Committed';
update awarddetail;
Redirect = new PageReference('/'+awarddetail.id);
return Redirect;
//return null;
}
 }