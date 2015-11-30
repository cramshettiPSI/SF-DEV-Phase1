public class appController {

// Return a list of the ten most recently modified contacts
public List<Application3__c> getapps() {
return [select Name,Project__c from Application3__c];
}

// Get the 'id' query parameter from the URL of the page.
// If it's not specified, return an empty contact.
// Otherwise, issue a SOQL query to return the contact from the
// database.
public Application3__c getapp() {
ID id = System.currentPageReference().getParameters().get('id');
return id == null ? new Application3__c() : [SELECT Name
FROM Application3__c];
}
public pagereference createProject(){
        return new Pagereference('/a0b/e?retURL=%2Fa0b%2Fo');
    }
     public pagereference cancel(){
    
        return new Pagereference('/apex/Login_Page');
    }
}