public with sharing class RiskIndicatorHelper {
	public static void rollUpScore(map<Id,Risk_Indicator__c> newMap,map<Id,Risk_Indicator__c> oldMap){
		
		system.debug('newmap = '+newMap);
		system.debug('oldmap = '+oldMap);
		set<Id> parentIds = new set<Id>(); 
		if(oldMap == null){
			//after insert
			for(Id i: newMap.keyset()){
				parentIds.add(newMap.get(i).Risk_Profile__c);
			}
		}else{
			//after update
			if(newMap!=null){
				for(Id i:newMap.keyset()){
					if(newmap.get(i).Total_Score__c != null && (oldMap.get(i).Total_Score__c != newMap.get(i).Total_Score__c)){
						parentIds.add(newMap.get(i).Risk_Profile__c);
					}
				}
			}else{
				for(Id i:oldMap.keyset()){					
					parentIds.add(oldMap.get(i).Risk_Profile__c);					
				}
			}
		}
		
		list<Risk_Profile__c> parentProfiles = new list<Risk_Profile__c>([Select r.Risk_Score__c, r.Name, r.Id, (Select Id, Total_Score__c,Risk_Profile__c  From Risk_Indicators__r) From Risk_Profile__c r where Id in :parentIds]);
		Map<Id, Decimal> parentValues = new Map<Id, Decimal>();
		if(parentProfiles.size()>0){
			for(Risk_Profile__c rp: parentProfiles){
				if(rp.Risk_Indicators__r.size()>0){
					for(Risk_Indicator__c ri: rp.Risk_Indicators__r){
						if(parentValues.keySet().contains(ri.Risk_Profile__c) && ri.Risk_Profile__c  != null && ri.Total_Score__c != null)
		           		{
		                	Decimal tmp = parentValues.get(ri.Risk_Profile__c);
		                	tmp += ri.Total_Score__c;
		                	parentValues.put(ri.Risk_Profile__c, tmp);
		            	}
		            	else
		            	{
		               		if(ri.Total_Score__c != null){
		                  		parentValues.put(ri.Risk_Profile__c, ri.Total_Score__c);
		                	}
						}
					}
				}
				if(parentValues.get(rp.Id)!=null){
	                rp.Risk_Score__c = parentValues.get(rp.Id);
	            }else{
	                rp.Risk_Score__c = 0;
	            }    
				
		    }
		    system.debug('parentProfiles = '+parentProfiles);
		    update parentProfiles;
		}
	}
}