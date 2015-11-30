global with sharing class CustomLoginController {

    

    global String username {get; set;}
    global String password {get; set;}
    global CustomLoginController () {}
    global PageReference login() {
        System.Debug('=========='+Site.login(username, password,'/CommunitiesLanding' ));
       return Site.login(username, password,'/CommunitiesLanding' ); 
      
    } 
   public pagereference joincommunity(){
        return new pagereference('/granteeportal/CommunitiesCustomSelfRegPage');
    } 
    
  /* public pagereference createOrg(){
      pagereference pgRef = new pagereference ('/apex/CreateOrganization');
        pgRef.setRedirect(true);
        return pgRef;
    } */
    
   public pagereference forgotPwd(){
        pagereference pgRef = new pagereference ('/apex/ForgotPassword');
        pgRef.setRedirect(true);
        return pgRef;        
        
    } 
   
    
}