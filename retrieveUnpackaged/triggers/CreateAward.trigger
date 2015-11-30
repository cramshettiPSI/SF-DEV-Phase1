trigger CreateAward on Application3__c (after update) {

List <Award__c> AwardInsert = new List <Award__c> ();

for (Application3__c App: Trigger.new)
{
if (App.Status__c == 'Accepted' && App.RecordTypeID == '012r00000004IJ5') {
Award__c Aw = new Award__c ();
Aw.Name = App.Name;
Aw.NOFA_Name__c = App.NOFA_RFP__c;
system.debug('app Id = '+app.Id);
Aw.Application_ID__c = App.ID;
Aw.Program_Officer__c = App.Program_Officer__c;
Aw.Senior_Program_Officer__c = App.Senior_Program_Officer__c;
Aw.Executive_Officer__c = App.Executive_Officer__c;
Aw.XO_CSHR__c = App.Ex_Officer_Cost_Share__c;
Aw.Senior_Grants_Officer__c = App.Senior_Grants_Officer__c;
Aw.Grants_Officer__c = App.Grants_Officer__c;
//Aw.Corporate_Program__c = App.Corporate_Program__c;
Aw.Subject_to_FAPIIS_Review__c= App.Subject_to_FAPIIS_Review__c;
Aw.FAPIIS_Review_Date__c= App.Date_FAPIIS_Review__c;
Aw.Information_Available__c= App.Information_available_FAPIIS_Review__c;
Aw.Satisfactory_Record_Executing_Programs__c= App.Satisfactory_Record_Executing_Programs__c;
Aw.Demonstrates_Ethics_Integrity__c= App.Demonstrates_Ethics_Integrity__c;
Aw.Mitigating_Circumstances__c= App.Mitigating_Circumstances__c;
Aw.FAPIIS_Review_Comments__c= App.FAPIIS_Review_Comments__c;

insert Aw;
}

}
}