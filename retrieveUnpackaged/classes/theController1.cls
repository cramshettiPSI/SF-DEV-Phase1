public class theController1 {

    public theController1(ApexPages.StandardController controller) {

    }


    public String getContact() {
        return null;
    }


    public PageReference cancel() {
        return null;
    }


    public PageReference save() {
        return null;
    }

 String searchText;
 List<Contact> accounts=new List<Contact>();
 List<Education__c> contacts= new List<Education__c>();
 List<Employment__c> opportunities=new List<Employment__c>();
 
   public List<Contact> getaccounts() {
   
      return accounts ;
   }
   public List<Education__c> getcontacts(){
       return contacts;
   }
   public List<Employment__c> getOpportunities(){
       return opportunities;
  
   }
        
}