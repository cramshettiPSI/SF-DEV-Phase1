public with sharing class StagesPanelling {

    public Boolean MyAllowAdd {get; set;}
    public Boolean MyAllowEdit {get; set;}
    public Boolean MyAllowDelete {get; set;}
    public String MyObj {get; set;}
    public String MyRecId {get; set;}
    public String MyRelationField {get; set;}
    public list<String> MyFieldList {get; set;}
    public list<String> MyLabelOverrideFieldList {get; set;}
    public list<String> MyLabelOverrideTextList {get; set;}
    public list<String> MyDefaultValueFieldList {get; set;}
    public list<String> MyDefaultValueTextList {get; set;}
    public String MyBlockTitle {get; set;}
    
    
    public StagesPanelling(ApexPages.StandardController stdController) {
    
        MyAllowAdd = true;
        MyAllowEdit = true;
        MyAllowDelete = true;
        MyBlockTitle = 'Panels for this Stage';
        MyObj = 'Paneling__c';
        MyRecId = stdController.getId();  // fill in your record Id here
        MyRelationField = 'Stage_Number__c';
        MyFieldList = new list<String> {'Id','Start_Date__c','End_Date__c','Type__c','Name'};
        MyLabelOverrideFieldList = new list<String> { 'Id'};
        MyLabelOverrideTextList = new list<String> {'Panels Id'};
        MyDefaultValueFieldList = new list<String> {};
        MyDefaultValueTextList = new list<String> {};
    }
}