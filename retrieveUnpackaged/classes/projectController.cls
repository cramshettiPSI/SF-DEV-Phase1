public class projectController {

    // Return a list of the ten most recently modified contacts
    public List<Project__c> getprojects() {
        return [select Name,Organization__c,Project_State__c,Project_Title__c,Street_Address_1__c,City__c,State__c from Project__c];
    }

    // Get the 'id' query parameter from the URL of the page.
    // If it's not specified, return an empty contact.
    // Otherwise, issue a SOQL query to return the contact from the
    // database.
    public  Project__c getProject() {
        ID id = System.currentPageReference().getParameters().get('id');
        return id == null ? new Project__c() : [SELECT Name FROM Project__c];
    }
    public pagereference createProject(){
        return new Pagereference('/a0W/e?retURL=%2Fa0W%2Fo');
        
    }
    public pagereference cancel(){
    
        return new Pagereference('/a0A/o');
    }
    public pagereference apply(){
     
     return new Pagereference('/apex/RedirectWithVariables?object=Application3__c&Project__c={!Project__c.Name}&ID_Project__c={!Project__c.Name}&RecordType=AmeriCorps NCCC');
     
    }
}