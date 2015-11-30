public with sharing class CustomSendEmailController {
        public String subject { get; set; }    
        public String body { get; set; }  
        public string toAddresses {get;set;}
        public string toCCAddresses {get;set;}
        public User auser {get;set;}
        public Id appId {get;set;}
        public Application3__c app{get;set;}
        public String status{get;set;}
        
        public CustomSendEmailController (){
            String tmpName = ApexPages.CurrentPage().getParameters().get('tmpName');
            toAddresses = ApexPages.CurrentPage().getParameters().get('toAddresses');
            status = ApexPages.CurrentPage().getParameters().get('status');
            appId = ApexPages.CurrentPage().getParameters().get('appId');
            //Application3__c app;
            system.debug('appId = '+appId);
            if(appId!=null){
             app = [Select Id,Name,Submitted_By__c, Comments__c,CreatedById,CreatedBy.Name,Grantee_Status__c,Status__c from Application3__c where Id = :appId];
        	}
        	system.debug('tmpName = '+tmpName);
            EmailTemplate template = [Select Id,Name,Body,Subject from EmailTemplate where DeveloperName = :tmpName];
            subject = template.Subject;            
            body = template.Body; 
            system.debug('createdById = '+app.CreatedById);
            User createdBy = [Select Id,Name from User where Id = :app.CreatedById];  
            system.debug('after user query = '+createdBy);
            if(body.contains('{!User.Name}'))
            	body = (null == app.CreatedById) ? body : body.replace('{!User.Name}',CreatedBy.Name); 
            if(body.contains('{!Application3__c.Comments__c}'))
            	body = (null == app.Comments__c) ? body.replace('{!Application3__c.Comments__c}','') : body.replace('{!Application3__c.Comments__c}',app.Comments__c);  
            if(body.contains('{!NOFA__c.CreatedBy}')){            	           	
            	body = (null == app.CreatedById) ? body : body.replace('{!NOFA__c.CreatedBy}',CreatedBy.Name);   
            }
            	      
        }
        
        public PageReference sendEmails(){
        	Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
            list<String> addressesToSend = new list<String>();
            list<String> addressesToCC = new list<String>();
            if(toAddresses!=null){
            	addressesToSend.add(toAddresses);
            }
            if(toCCAddresses != null && toCCAddresses !=''){            	
            	addressesToCC = toCCAddresses.split(';');
            }            
            email.setSubject( subject );
            email.setToAddresses( addressesToSend );
            email.setPlainTextBody( body );      
            if(addressesToCC.size()>0){            	
            	email.setCcAddresses(addressesToCC);
            }                                  
            app.Grantee_Status__c = status;
 			app.Status__c = status;      
 			Database.Saveresult appUpdate = Database.update(app);
 			//update app;     
 			if(appUpdate.isSuccess()){
 				try{
 					Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});    
               		//ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Successfully sent email(s) to contacts'));
 				} catch(Exception e){            	
           			 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Unable to send email, please contact your admin'));
           			 return null;
           		}
 			}else{
 				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Unable to update Concept Paper, please contact your admin'));
 				return null;
 			}           
        	PageReference pg = new PageReference('/'+appId);
        	pg.setRedirect(true);
            return pg;
        }
        
        public PageReference cancel(){
        	 PageReference pg = new PageReference('/'+appId);
        	 system.debug('appId = '+appId);
        	 pg.setRedirect(true);
             return pg;
        }
}