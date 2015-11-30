/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
public with sharing class CommunitiesSelfRegController {

    /*public Contact Con;
    String conEmail{get;set;}
    apexpages.standardController sController;*/
    
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
    
    public CommunitiesSelfRegController() {}
    
    /*public CommunitiesSelfRegController(ApexPages.StandardController stdController) {
        sController = stdController;
        this.Con = (Contact)stdController.getRecord();

    }*/
    
    
    private boolean isValidPassword() {
        return password == confirmPassword;
    }
    
    
    
    public pagereference Cancel(){
       pagereference pr  =new pagereference('/apex/Login_Page'); 
       return pr;
    
    }

    public PageReference registerUser() {
    
        try{
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
                // it's okay if password is null - we'll send the user a random password in that case
                if (!isValidPassword()) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
                ApexPages.addMessage(msg);
                return null;
                }

                system.Debug('contact======='+contact);
                String profileId = '00er0000000Lr57'; // To be filled in by customer.
                String roleEnum = 'Externalusers'; // To be filled in by customer.
                String accountId = '001r0000004arr6'; // To be filled in by customer.
                system.Debug('contact======='+contact.id);
                contact.Accountid = accountId;
                upsert contact;    
                String ContactId = contact.Id;

                String userName = email;

                User u = new User(ProfileId = profileId);
                u.Username = contact.Email;
                u.Email = contact.Email;
                u.FirstName = contact.FirstName;
                u.LastName = contact.LastName;
                u.Contactid=contact.Id;
                u.CommunityNickname = contact.FirstName+''+contact.LastName;//communityNickname;
                system.debug(' CommunityNickname= '+ u.CommunityNickname);
                system.debug('user = '+accountId);
                system.debug('password= '+password);
                // system.Debug('============portaluser======'+Site.createPortalUser(u, accountId, password));

                String userId = Site.createPortalUser(u, accountId, password);
                system.debug('userId = '+userId);
                if (userId != null) { 

                if (password != null && password.length() > 1) {
                return Site.login(userName, password, ApexPages.currentPage().getParameters().get('startURL'));
                // return Site.login(username, password, null);
                }
                else {
                system.debug('In Else part ');              
                PageReference page = new pagereference('/apex/SearchOrganization?uid='+ContactId);
                page.setRedirect(true);
                return page;
                }
                }
                }
            }
            catch(exception ex)
            {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Username Already exists'+ ex));
            }
            return null;
    }
}