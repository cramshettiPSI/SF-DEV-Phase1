public class ContactSearchCTRL {

 public list<contact> contactlist{get;set;}
public decimal rating{get;set;}
 public string debugsoql{get;set;}
 public boolean txt{set;get;}
 
 
    public ContactSearchCTRL(ApexPages.StandardController controller) {
          contactlist = new list<contact>();
          contactlist = [select firstname,lastname,Area_of_Expertise__c,Highest__c,Performance_Rating__c,Status__c,State_of_Residence__c from contact];
    }

public void runsearch()
{
    string soql;
    string area = Apexpages.currentPage().getParameters().get('area');
    string education = Apexpages.currentPage().getParameters().get('education');
   string status = Apexpages.currentPage().getParameters().get('status');
    string residence = Apexpages.currentPage().getParameters().get('residence');
    String  rating1= Apexpages.currentPage().getParameters().get('rating');
if(rating1 !='') {
 rating  = decimal.Valueof(rating1);
   }
    else {
    rating = 0;}
    System.debug('test::'+rating);
  //Decimal.valueOf  
  
    string t1='\'';
    string t2= '\'';
    
   
    
   // if((area =='' || area == null) && (education =='' || education == null) && (status =='' || status == null) && (residence =='' || residence == null) && rating == 0 )
   
     if((area =='' || area == null) && (education =='' || education == null) && (residence =='' || residence == null) && (status =='' || status == null) && rating < 1)
    {
     soql = 'select firstname,lastname,Area_of_Expertise__c,Highest__c,Performance_Rating__c,State_of_Residence__c,Status__c from contact ';
     //soql = 'select firstname,lastname,Area_of_Expertise__c,Highest__c,Performance_Rating__c,Status__c,State_of_Residence__c from contact';
     
   
}
    else
    {
     soql = 'select firstname,lastname,Area_of_Expertise__c,Highest__c,Performance_Rating__c,State_of_Residence__c,Status__c from contact where lastname!='+t1+t2 ;
     if (!area.equals(''))
    soql += ' AND Area_of_Expertise__c = '+t1+area+t2;
    
    if (!education.equals(''))
   soql += 'AND  Highest__c = '+t1+education+t2;
  
 
   if (!residence.equals(''))
  soql += ' AND State_of_Residence__c = '+t1+residence+t2;
  
  if (!status.equals(''))
  soql += ' AND Status__c = '+t1+status+t2;
  if(rating <1) {
soql+='';
}
else {
   soql += ' AND Performance_Rating__c= '+rating;
}
    // run the query again
   // runQuery();
    //return null;
       system.debug('**************************************query'+soql);
    contactlist = database.query(soql);
    debugsoql = soql;
    
    }   
    //soql = 'select id,firstname, lastname,Area_of_Expertise__c,Highest__c,Performance_Rating__c,Status__c,State_of_Residence__c from contact where Area_of_Expertise__c='+t1+area+t2+' and Highest__c='+t1+education+t2+' and Performance_Rating__c='+rating+' and status__c='+status+' and State_of_Residence__c='+residence ;
  //  soql = 'select id,firstname, lastname,Area_of_Expertise__c,Highest__c,Performance_Rating__c,State_of_Residence__c from contact where Area_of_Expertise__c='+t1+area+t2+' and Highest__c='+t1+education+t2+' and Performance_Rating__c='+rating+'and State_of_Residence__c='+residence ;

    
 
}
}