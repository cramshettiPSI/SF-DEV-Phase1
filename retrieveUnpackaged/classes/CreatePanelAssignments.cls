public with sharing class CreatePanelAssignments
{
    private ApexPages.StandardController standardController;
 
    public CreatePanelAssignments(ApexPages.StandardController standardController)
    {
        this.standardController = standardController;
    }
 
    public PageReference AssignPanels()
    {
     PageReference pageRef = ApexPages.currentPage();
        // Apex code for handling record from a Detail page goes here
        Id recordId = standardController.getId();
        list<Attachment__c> attachmentsToAdd = new list<Attachment__c>();
        Paneling__c panel = [Select Id,Name,Stage_Number__c from Paneling__c where Id = :recordId];
        Stages__c stage = [Select s.Name, s.Id, (Select Id, Attachment_Id__c, Name, Description__c, Type__c, Stages__c From Attachments__r) From Stages__c s where Id = :panel.Stage_Number__c];
        
        Set<Id> PanelMembers = new Set<Id>();
        Set<Id> PanelApplications = new Set<Id>();
        map<Id,Id> reviewerIdtoPMId = new map<Id,Id>();
        List<Expert_Review_Panel__c> ExpertReviewPanels = new List<Expert_Review_Panel__c>();
        List<Application_Feedback__c> AppFeedbackList = new List<Application_Feedback__c>();
        
        /* Get a list of all of the Contacts associated with the panel */
        List<Panel_Member__c> panelMemberList = new List<Panel_Member__c>();
        panelMemberList = [SELECT Id,Expert_Reviewer__c FROM Panel_Member__c where Panel__c = :recordId];
        for(Panel_Member__c pm: panelMemberList){
          PanelMembers.add(pm.Expert_Reviewer__c);
          reviewerIdtoPMId.put(pm.Expert_Reviewer__c,pm.Id);
        }

        /* Get a list of all of the Applications associated with the panel */
        List<Panel_Application__c> panelApplicationList = new List<Panel_Application__c>();
        panelApplicationList = [SELECT Application__c FROM Panel_Application__c where Paneling__c = :recordId];
        for(Panel_Application__c pm: panelApplicationList){
          PanelApplications.add(pm.Application__c);
        }
        
        /* Create an Expert Reviewer Panel Object for each Reviewer */
        for (ID PanelMembersID: PanelMembers){
            Expert_Review_Panel__c exp = new Expert_Review_Panel__c();
            exp.Reviewer__c = PanelMembersID;
            exp.Panel__c = recordId;
            exp.Panel_Member__c = reviewerIdtoPMId.get(PanelMembersID);
            //Set the Status
            ExpertReviewPanels.add(exp);
        }
        insert ExpertReviewPanels;
        
        /* Create an Expert Reviewer Panel Object for each Reviewer */
        for (Expert_Review_Panel__c ExpertPanel: ExpertReviewPanels){
            for (ID ApplicationID: PanelApplications){
                Application_Feedback__c appFeedback = new Application_Feedback__c();
                appFeedback.Expert_Review_Panel__c = ExpertPanel.Id;
                appFeedback.Application__c = ApplicationID;
                //Need to add the Feedback Form
                AppFeedbackList.add(appFeedback);
            }  
        
        }
        insert AppFeedbackList;
        
        /*for(Expert_Review_Panel__c ExpertPanel: ExpertReviewPanels){
            if(stage.Attachments__r.size()>0){
                for(Attachment__c a: stage.Attachments__r){
                    Attachment__c newAttachment = new Attachment__c();
                    newAttachment.Name = a.Name;
                    newAttachment.Attachment_Id__c = a.Attachment_Id__c;
                    newAttachment.Expert_Review_Panel__c = ExpertPanel.Id;
                    newAttachment.Type__c = a.Type__c;
                    newAttachment.Description__c = a.Description__c;
                    newAttachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Panel Attachment').getRecordTypeId();
                    attachmentsToAdd.add(newAttachment);
                }
            }
        }
        
        if(attachmentsToAdd.size()>0){
            insert attachmentsToAdd;
        }       */
        
        return null;
    }
    

}