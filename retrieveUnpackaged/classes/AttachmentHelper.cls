public with sharing class AttachmentHelper {
	public static void createcustomAttachment(list<Attachment> attachments){
		
		String keyPrefix = Application3__c.sObjectType.getDescribe().getKeyPrefix();
		list<Attachment__c> attachmentsToAdd = new list<Attachment__c>();	
		
		map<String,Id> NametoIdMap = new map<String,Id>();	
		map<String,Id> IdMap = new map<String,Id>();
		
		for(Attachment a: attachments){
			String prefix = a.ParentId;
			if(prefix.startswith(keyPrefix)){
				Attachment__c newCustomAttachment = new Attachment__c();												
				newCustomAttachment.Name = a.Name;
				newCustomAttachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Application Attachment').getRecordTypeId();
				newCustomAttachment.Application__c = a.ParentId;							
				attachmentsToAdd.add(newCustomAttachment);	
									
			}		
		}
		if(attachmentsToAdd.size()>0){
			insert attachmentsToAdd;
			for(Attachment__c a: attachmentsToAdd){
				NametoIdMap.put(a.Name,a.Id);
			}
		}
				
		for(Attachment a: attachments){
			String prefix = a.ParentId;
			if(prefix.startswith(keyPrefix)){
				a.ParentId = NametoIdMap.get(a.Name);
			}
		}
		
		
	}
	
	
	public static void updateAttachmentId(list<Attachment> attachments){
		String appkeyPrefix = Application3__c.sObjectType.getDescribe().getKeyPrefix();
		String cAttachkeyPrefix = Attachment__c.sObjectType.getDescribe().getKeyPrefix();
		
		set<Id> parentIds = new set<Id>();
		map<String,Id> sNametoIdMap = new map<String,Id>();
		list<Attachment__c> cAttachments = new list<Attachment__c>();	
		list<Attachment__c> attachmentsToUpdate = new list<Attachment__c>();	
		for(Attachment a:attachments){
			String parent = a.ParentId;
			if(a.ParentId!=null && parent.startsWith(cAttachkeyPrefix)){
				parentIds.add(a.ParentId);
				sNametoIdMap.put(a.Name,a.Id);
			}
		}
			
		cAttachments = [Select Id,Name,Application__c from Attachment__c where id in :parentIds];		
		if(cAttachments.size()>0){
			for(Attachment__c a: cAttachments){
				if(a.Application__c!=null){
					a.Attachment_Id__c = sNametoIdMap.get(a.Name);
					attachmentsToUpdate.add(a);
				}
			}			
		}
		if(attachmentsToUpdate.size()>0){
			update attachmentsToUpdate;
		}
		
	} 
	
	
}