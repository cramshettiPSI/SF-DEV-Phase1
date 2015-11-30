public with sharing class AwardReportingHelper {
    public static void lockFFR(map<Id,Award_Reporting__c> newMap, map<Id,Award_Reporting__c> oldMap){
    	Id ffrRTId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Federal Financial Reports').getRecordTypeId();
    	map<String, Schema.SObjectField> awardReportfields= Schema.getGlobalDescribe().get('Award_Reporting__c').getDescribe().fields.getMap();
    	for(Id i:newMap.keyset()){
    		if(newMap.get(i).RecordTypeId == ffrRTId){
    			if((oldMap.get(i).Status__c == 'Submitted' && newMap.get(i).Status__c == 'Submitted') || (oldMap.get(i).Status__c == 'Re-submitted' && newMap.get(i).Status__c == 'Re-submitted')){    			
    				Award_Reporting__c oldRec = oldMap.get(i);
    				Award_Reporting__c newRec = newMap.get(i);
    				for(String s:awardReportFields.keyset()){
    					if(oldRec.get(s) != newRec.get(s)){    					  
    						newMap.get(i).addError('FFR cannot be edited when its submitted status');
    					}
    				}    				
    			}
    		}
    	}
    }
    
    public static void fieldUpdates(map<Id,Award_Reporting__c> newMap, map<Id,Award_Reporting__c> oldMap){
    	Id ffrRTId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Federal Financial Reports').getRecordTypeId();
    	for(Id i:newMap.keyset()){
    		if(newMap.get(i).RecordTypeId == ffrRTId){
    			if((oldMap.get(i).Status__c != newMap.get(i).Status__c) &&  (oldMap.get(i).Status__c != 'Submitted' && newMap.get(i).Status__c == 'Submitted')){
    				Award_Reporting__c oldRec = oldMap.get(i);
    				Award_Reporting__c newRec = newMap.get(i);
    				if((newRec.Unobligated_balance_of_federal_funds__c/newRec.Total_federal_share__c) <= (0.2 * newRec.FedShareUnliquidatedObligation_ThisPerio__c))
    					newRec.Drawdowns_within_20_of_reported_OBG__c = 'Yes';
    				else
    					newRec.Drawdowns_within_20_of_reported_OBG__c = 'No';
    					
    				if(newRec.Submitted_Date__c <= newRec.Due_Date__c)
    					newRec.Timely_Submission__c = 'On-Time';
    				else
    					newRec.Timely_Submission__c = 'Late';    					
    				
    			} 
    		}
    	}
    }
}