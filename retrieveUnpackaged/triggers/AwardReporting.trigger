trigger AwardReporting on Award_Reporting__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	if(trigger.isAfter){
		if(trigger.isUpdate){
			AwardReportingHelper.lockFFR(trigger.newMap,trigger.oldMap);			
		}
	}
	
	if(trigger.isBefore){
		if(trigger.isUpdate){
			//AwardReportingHelper.fieldUpdates(trigger.newMap,trigger.oldMap);
		}
	}
}