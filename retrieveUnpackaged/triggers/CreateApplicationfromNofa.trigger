trigger CreateApplicationfromNofa on NOFA__c (After insert, After update) {
List <Application3__c> AppToInsert = new List <Application3__c> ();
for (NOFA__c c : Trigger.new) {
if (c.RSVP_Only__c == True) {
Application3__c a = new Application3__c ();
a.State_Application_Identifier__c='Test';
AppToInsert.add(a);
}
}
insert AppToInsert;
}