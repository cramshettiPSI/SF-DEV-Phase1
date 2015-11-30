trigger RiskIndicator on Risk_Indicator__c (after insert,after update, after delete) {
    if(trigger.isAfter){
        if(trigger.isUpdate || trigger.isInsert || trigger.isDelete){
            RiskIndicatorHelper.rollUpScore(trigger.newMap,trigger.oldMap);
        }
    }
}