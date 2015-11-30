public with sharing class ContactCreateController {

    public ContactCreateController(ApexPages.StandardController controller) {

    }


    public String getEducation() {
        return null;
    }


       // the account record you are adding values to
  public Account account {
    get {
      if (account == null)
        account = new Account();
      return account;
    }
    set;
  }


  // the contact record you are adding values to
  public Contact contact {
    get {
      if (contact == null)
        contact = new Contact(Account=account);
      return contact;
    }
    set;
  }

// the opportunity record you are adding values to
  public Opportunity opportunity{
    get {
      if (opportunity== null)
        opportunity= new Opportunity();
      return opportunity;
    }
    set;
  }
  public ContactCreateController() {
    // blank constructor
        
  }

  // save button is clicked
  public PageReference save() {

    try {
      insert account; // inserts the new record into the database 
      insert contact; // inserts the new record into the database
      System.debug('Account id in contact object------>'+contact);
    ///  insert opportunity; // inserts the new record into the database
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error creating new contact.'));
      return null;
    }

    // if successfully inserted new contact, then displays the blank Expert Application page.
    return null;
  }

}