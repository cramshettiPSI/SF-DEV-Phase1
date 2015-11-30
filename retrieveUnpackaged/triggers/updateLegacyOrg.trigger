trigger updateLegacyOrg on Account (before update) {
    for (Account obj: trigger.new){
        if (Trigger.isUpdate){
           if(obj.ID__c != null){
            MuleNotifier.notifyMule('org',String.valueOf(obj.ID__c.intValue()));
           } 
        }
    } 
}