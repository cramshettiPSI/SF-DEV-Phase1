public with sharing class CommunitiesSelfRegController1 {

   
  
   
    
    public Contact contact {
    get {
            if (contact == null)
                contact = new Contact();
            return contact;
        }
        set;
    }
    
    public String firstName {get; set;}
    public String lastName {get; set;}
    public String email {get; set;}
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }
    
    public CommunitiesSelfRegController1 () {}
    
     private boolean isValidPassword() {
        return password == confirmPassword;
    }
       public pagereference Cancel(){
       pagereference pr  =new pagereference('/apex/CommunitiesLogin'); 
       return pr;
           }


        public PageReference registerUser() 
        {
            PageReference Redirect;
            
            try
               {
                    if(contact.Email!=contact.Re_Enter_Email__c)
                    {           
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Email and Re-Enter Email address should be same.'));
                    }
                    else if(contact.New_Password__c!=contact.Re_Enter_Password__c)
                    {           
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Password and Re-Enter Password should be same.'));
                    }
                    else
                    {
                        
                        system.Debug('========enter registeruser');

                        if (!isValidPassword()) 
                        {
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
                        ApexPages.addMessage(msg);
                        return null;
                        }

                        system.Debug('contact======='+contact);
                        //String profileId = '00er0000000LrAvAAK'; // To be filled in by customer.
                        String profileId = '00er0000000LrB0'; // To be filled in by customer.
                        String roleEnum = 'Expertreviewers'; // To be filled in by customer.
                        String accountId = '001r0000004acZP';  // To be filled in by customer.


                        contact.Accountid = accountId;
                        //   If(userId!=null && userId!=''){
                        
                        insert contact; 
                        system.Debug('============contact======'+contact);

                        String userName = email;

                        User u = new User(ProfileId = profileId);
                        u.Username = contact.email;
                        system.Debug('============Username======'+u.Username);
                        u.Email = contact.email;
                        system.Debug('============Email======'+u.Email);
                        u.FirstName = contact.FirstName;
                        u.LastName = contact.LastName;
                        u.Contactid=contact.Id;
                        system.Debug('============Contactid======'+u.Contactid);
                        DateTime currentTime = System.now(); Long timeInMili = currentTime.getTime()/1000; 
                      u.CommunityNickname = contact.FirstName+''+contact.LastName +timeInMili;//communityNickname;
                       // system.Debug('============portaluser======'+Site.createPortalUser(u, accountId, password));
                        String userId = Site.createPortalUser(u, accountId, password);
                        contact.OwnerId =  userId;
                     //   Contact NewContact = [select Id, OwnerId from Contact where Id = :contact.Id limit 1 ];
                       // NewContact.OwnerId = '005r0000000I84I';
                        //update NewContact;
                        
                        system.Debug('============userId ======'+userId );
                        if (userId != null) { 
                        if (password != null && password.length() > 1) {
                        return Site.login(username, password, null);
                        }
                        else {
                        PageReference page = System.Page.communitiesSelfRegConfirm1;
                        page.setRedirect(true);
                        return page;
                        }
                        
                    
                    }   
            
                }
            }   
                
              catch(exception ex)
                {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'error====='+ ex));
                }
                return null;
        }
}