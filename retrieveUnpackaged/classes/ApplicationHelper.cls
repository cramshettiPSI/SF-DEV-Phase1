public with sharing class ApplicationHelper {
    public static void checkApplicationforSameYr(list<Application3__c> newApps){
        set<Id> projectIds = new set<Id>();
        set<Id> nofaIds = new set<Id>();
        list<Project__c> projects = new list<Project__c>();              
        Id appRecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        for(Application3__c a: newApps){
        system.debug('newApps= '+newApps);        
          if(a.Project__c != null && appRecordTypeId == a.RecordTypeId){
             projectIds.add(a.Project__c);
          }
        }        
        projects = [Select p.Name, p.Id,p.Organization__c, (Select Id, Name,NOFA_RFP__c,NOFA_RFP__r.Fiscal_Yr__c,NOFA_Fiscal_Yr__c,Project__c From Application__r) From Project__c p where Id in : projectIds];        
        for(Project__c p: projects){            
            if(p.Application__r!=null){
                for(Application3__c a: p.Application__r){
                  if(a.RecordTypeId == appRecordTypeId){
                    nofaIds.add(a.NOFA_RFP__c);
                  }  
                }
                for(Application3__c newApp: newApps){
                    nofaIds.add(newApp.NOFA_RFP__c);
                }
            }
        }
        
       Map<Id,Nofa__c> nofaFiscalYrs = new Map<Id,Nofa__c>([Select Id,Fiscal_Yr__c from NOFA__c where Id in :nofaIds]);      
       
        for(Project__c p: projects){
            
            for(Application3__c newApp: newApps){               
                if(p.Application__r.size()>0){
                    for(Application3__c a: p.Application__r){       
                        if(a.RecordTypeId == appRecordTypeId){                                 
                            if(a.Project__c == newApp.Project__c && a.NOFA_RFP__c == newApp.NOFA_RFP__c && (a.NOFA_Fiscal_Yr__c != '' && a.Nofa_Fiscal_yr__c != null) && a.NOFA_Fiscal_Yr__c == nofaFiscalYrs.get(newApp.NOFA_RFP__c).Fiscal_Yr__c){                           	
                                newApp.adderror('A project can only be attached to a single application in a fiscal year');                           
                        	}
                        }
                     } 
                    
                }
                         
                /*else if(p.Application__r.size() == 0 && p.Organization__c!=null){
                    system.debug('got here 2');
                    Boolean isDupe = isDupeAppWithaDiffProject(p.Organization__c,newApp.NOFA_RFP__c,nofaFiscalYrs.get(newApp.NOFA_RFP__c));
                    if(isDupe){
                        newApp.adderror('A project can only be attached to a single application in a fiscal year');
                    }   
                }*/
            }
        }
        
        
    }    
    
    
    /*public static boolean isDupeAppWithaDiffProject(Id orgId,Id nofaId,String yr){
        set<Id> projectIds = new set<Id>();
        list<Project__c> projects = new list<Project__c>();
        
        Account a = [Select a.Name, a.Id, (Select Name From Projects__r) From Account a where Id = :orgId];
        if(a!=null && a.Projects__r != null){
            for(Project__c p: a.Projects__r){
                projectIds.add(p.Id);
            }   
        }
        system.debug('project Ids = '+projectIds);
        projects = [Select p.Name, p.Id,p.Organization__c, (Select Id, Name,NOFA_RFP__c,NOFA_RFP__r.Fiscal_Yr__c,NOFA_Fiscal_Yr__c,Project__c From Application__r) From Project__c p where Id in : projectIds];        
        
        for(Project__c p: projects){
            if(p.Application__r!=null){
                for(Application3__c app: p.Application__r){                 
                    if(app.Nofa_RFP__c == nofaId && app.NOFA_Fiscal_Yr__c == yr){
                        return true;
                    }
                    
                }
            }
        }
        return false;
        
    }*/
    
    /*public static void populateOrg(list<Application3__c> newapps){
        set<Id> usrIds = new set<Id>();
        map<Id,Id> usrIdtoOrgId = new map<Id,Id>();
        for(Application3__c a: newapps){
            if(a.Applicant_User__c !=null){
                usrIds.add(a.Applicant_User__c);
            } 
        }
        system.debug('usrIds = '+usrIds);
        list<User> users = new list<User>([Select u.Name, u.Id, u.AccountId From User u where Id in :usrIds]);
        for(User u:users){
            if(u.AccountId!=null)
                usrIdtoOrgId.put(u.Id,u.AccountId);
        }
        system.debug('user map = '+usrIdtoOrgId);
        for(Application3__c a:newApps){
            if(usrIdtoOrgId.get(a.Applicant_User__c)!=null){
                a.Organization__c = usrIdtoOrgId.get(a.Applicant_User__c);
            }
        }
        
    }*/
    
}