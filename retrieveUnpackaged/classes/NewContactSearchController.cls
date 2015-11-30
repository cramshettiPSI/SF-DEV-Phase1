public with sharing class NewContactSearchController {

  //  public String c { get; set; }

  // the soql without the order and limit
  private String soql {get;set;}
  // the collection of contacts to display
  public List<Contact> contacts {get;set;}
   public boolean txt{set;get;}
  
  
  //Our collection of the class/wrapper objects cContact
  public List<cContact> contactList {get; set;}
    
    //This method uses a simple SOQL query to return a List of Contacts
//  public List<cContact> getMyContacts() {
//      if(contactList == null) {
//          contactList = new List<cContact>();
//          contacts = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 100');
            
//          for(Contact c: contacts) {
                // As each contact is processed we create a new cContact object and add it to the contactList
//              contactList.add(new cContact(c));
//          }
//      }
//      return contactList;
//  }
 
 
    public PageReference processSelected() {
 
                //We create a new list of Contacts that we be populated only with Contacts if they are selected
        List<Contact> selectedContacts = new List<Contact>();
         //We will cycle through our list of cContacts and will check to see if the selected property is set to true, if it is we add the Contact to the selectedContacts list
//        for(cContact cCon: getMyContacts()) {
//            if(cCon.selected == true) {
 //               selectedContacts.add(cCon.con);
//            }
//        }

        // Now we have our list of selected contacts and can perform any type of logic we want, sending emails, updating a field on the Contact, etc
        System.debug('These are the selected Contacts...');
        for(Contact con: selectedContacts) {
            system.debug(con);
        }
        contactList=null; // we need this line if we performed a write operation  because getContacts gets a fresh list now
        return null;
    }
 
    // This is our wrapper/container class. A container class is a class, a data structure, or an abstract data type whose instances are collections of other objects. In this example a wrapper class contains both the standard salesforce object Contact and a Boolean value
    public class cContact {
        public Contact con {get; set;}
        public Boolean selected {get; set;}

        //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
        public cContact(Contact c) {
            con = c;
            selected = false;
        }
    }
 

  // the current sort direction. defaults to asc
  public String sortDir {
    get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
    set;
  }

  // the current field to sort by. defaults to last name
  public String sortField {
    get  { if (sortField == null) {sortField = 'lastName'; } return sortField;  }
    set;
  }

  // format the soql for display on the visualforce page
  public String debugSoql {
    get { return soql + ' order by ' + sortField + ' ' + sortDir + ' limit 100'; }
    set;
  }

  // init the controller and display some sample data when the page loads
  public NewContactSearchController () {
    soql = 'select firstname, lastname, account.name,State_of_Residence__c from contact';
    contactList = new List<cContact>();
    contacts = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 100');
    
    for(Contact c: contacts) {
        // As each contact is processed we create a new cContact object and add it to the contactList
        contactList.add(new cContact(c));
    }

    runQuery();
  }

  // toggles the sorting of query from asc<-->desc
  public void toggleSort() {
    // simply toggle the direction
    sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    // run the query again
    runQuery();
  }
 
  // runs the actual query
  public void runQuery() {

    try {
      contacts = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 100');
//      contactList = null;
//      contactList = getMyContacts();
        
        
        contactList = new List<cContact>();
            
        for(Contact c: contacts) {
            // As each contact is processed we create a new cContact object and add it to the contactList
            contactList.add(new cContact(c));
        }
            
    } catch (Exception e) {
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
    }

  }

  // runs the search with parameters passed via Javascript
  public PageReference runSearch() {

    String firstName = Apexpages.currentPage().getParameters().get('firstname');
    String lastName = Apexpages.currentPage().getParameters().get('lastname');
    String accountName = Apexpages.currentPage().getParameters().get('accountName');
    String State = Apexpages.currentPage().getParameters().get('State_of_Residence__c');
    String Status1 = Apexpages.currentPage().getParameters().get('Status__c');
    String Rating = Apexpages.currentPage().getParameters().get('Performance_rating__c');
    String Expertise= Apexpages.currentPage().getParameters().get('Area_of_expertise__c');        // run the query again

    soql = 'select Id,firstname, lastname, account.name,State_of_Residence__c from contact where account.name != null';
    if (!firstName.equals(''))
    soql += ' and firstname LIKE \''+String.escapeSingleQuotes(firstName)+'%\'';
    if (!lastName.equals(''))
    soql += ' and lastname LIKE \''+String.escapeSingleQuotes(lastName)+'%\'';
    if (!accountName.equals(''))
    soql += ' and account.name LIKE \''+String.escapeSingleQuotes(accountName)+'%\''; 
    if (!State.equals(''))
      soql += ' and State_of_Residence__c IN (\''+State +'\')';
    runQuery();

    return null;
  }


}