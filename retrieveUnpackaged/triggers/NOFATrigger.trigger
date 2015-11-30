trigger NOFATrigger on NOFA__c (before insert,Before update) 

{

set<Id> cncsIds = new set<Id>();
set<String> cncsProgramNames = new set<String>();
map<Id,String> cncsCPIdtoName = new map<Id,String>();
map<String,Id> pNametoId = new map<String,Id>();
if(trigger.isBefore){
  if(trigger.isInsert || trigger.isUpdate){
    for(NOFA__c a: trigger.new){
      cncsIds.add(a.CNCS_Corporate_Program__c);
    }
    list<CNCS_Corporate_Program__c> lcncsp = new list<CNCS_Corporate_Program__c>([Select Id,Name from CNCS_Corporate_Program__c where id in :cncsIds ]);
    for(CNCS_Corporate_Program__c c: lcncsp){
      cncsProgramNames.add(c.Name);
      cncsCPIdtoName.put(c.Id,c.Name);
    }
    
    list<Product2> lprod = new list<Product2>([select Id,Name from Product2 where name in :cncsProgramNames]);
    for(Product2 p: lprod){
      pNametoId.put(p.Name,p.Id);
    }
    for(NOFA__c a: trigger.new){
      a.Corporate_Program__c = pNametoId.get(cncsCPIdtoName.get(a.CNCS_Corporate_Program__c));
    }
    
  }
  }
  
  }