trigger UpdateChildFields on NOFA__c (before insert, before update) {

    for (NOFA__c obj: trigger.new){
        if (obj.Parent_NOFA__c != null)
            obj.Allow_planning_grants_for_this_NOFA__c = obj.Parent_NOFA__r.Allow_planning_grants_for_this_NOFA__c;
     }
     
     for(NOFA__c n: trigger.new){
        if(n.Required__c !=null && n.Organization_Docs__c != null )
        {
            String required =  n.Required__c;
            String orgDocs = n.Organization_Docs__c;
            system.debug('required = '+required);
            system.debug('org Docs = '+orgDocs);
            
            if(required.contains(orgDocs))
                n.addError('Same Type cannot be in both fields: Required and Oranization Docs');
        }   
     
     }
}