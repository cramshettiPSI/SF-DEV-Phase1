global with sharing class CustomLoginController1 {

    

    global String username {get; set;}
    global String password {get; set;}
    global CustomLoginController1 () {}
    global PageReference forwardToCustomAuthPage() {
        return new PageReference('/CommunitiesCustomSelfRegPage1');
    }
    global PageReference login() {
        System.Debug('=========='+Site.login(username, password,'/CommunitiesLanding' ));
       return Site.login(username, password,'/CommunitiesLanding' ); 
      
    } 
    
}