public class LocationExtension {
 

    Public Location__c locationInput{get;set;}    
    public String id;
    public String Locationid;
   // public String Id;
    Public String nofaid;
    public Application3__c Application {get;set;}
    public NOFA__c Nofa{get;set;}
    public String queryString {get;set;}
    private ApexPages.StandardController scontroller;
    
    
    
    public LocationExtension getThis(){
        return this;
    }
    
   public LocationExtension (ApexPages.StandardController controller) 
    {           
            sController = controller;
            locationInput= new Location__c();
            System.debug('State_####'+locationInput.State__c);
          Locationid=Apexpages.currentPage().getParameters().get('Locationid');  
           // nofaid=Apexpages.currentPage().getParameters().get('nofaid');  
            id=Apexpages.currentPage().getParameters().get('applicationid');    
           
            If(id!=null && id!='')
     // locationInput=[select Application__r.NOFA_RFP__r.Volunteer_Information__c,Application__c,Beds_Provided__c,Capacity_Building__c,City__c,Description_of_Accessibility__c,Disaster_Services__c,Distance_to_Location_of_Service__c,Economic_Opportunities__c,Education__c,Environmental_Stewardship__c,Healthy_Futures__c,Is_this_a_K_12_school__c,Kitchen__c,Laundry__c,Location_EIN__c,Location_Type__c,Lodging_Arrival_Date__c,Lodging_Category__c,Lodging_Departure_Date__c,Lodging_Description__c,Lodging_Type__c,NOFA1__c,NOFA__c,Number_of_Unduplicated_Volunteers__c,Number_of_Volunteers__c,Other_Capacity_Building__c,Other_Disaster_Services__c,Other_Economic_Opportunities__c,Other_Education__c,Other_Environmental_Stewardship__c,Other_Healthy_Futures__c,Other_Veterans_Military_Families__c,Projected_End_Date__c,Projected_Start_Date__c,Refrigerator_Microwave__c,Shower__c,Site_Type__c,State__c,Station_Type__c,Street_Address_1__c,Street_Address_2__c,Summer_Associates__c,Supervisor_Email__c,Supervisor_Name__c,Supervisor_Organization__c,Supervisor_Phone_Number__c,Supervisor_Phone_Number_Extension__c,Undisclosed_Location__c,Veterans_Military_Families__c,Veterans_Served__c,Zip__c from Location__c where id=:Locationid];                    
  
  If(id!=null && id!='')
  Application=[Select Id,Name,NOFA_RFP__c,NOFA_RFP__r.Volunteer_Information__c,Nofa_RFP__r.School_Information__c,NOFA_RFP__r.Focus_Area_and_Objectives_Location__c,Nofa_RFP__r.Standard_Information__c,
   NOFA_RFP__r.EIN_Information__c,Nofa_RFP__r.Site_Date_Information__c,NOFA_RFP__r.Site_Type__c,Nofa_RFP__r.Site_Type_and_Summer_Associates__c,NOFA_RFP__r.Additional_Operating_Site_Information__c,Nofa_RFP__r.Lodging_Information__c from Application3__c where id=:id]; 

 locationInput.Application__c =id;
 system.debug('$$$ '+ id+ '###'+ locationInput.Application__c + '&&&' +Application.id);
system.debug('@@@PRASHANT'+id+'$$$'+Application.id);

PageReference thisPage = ApexPages.currentPage();

    List<String> url = thisPage.getUrl().split('\\?');

    queryString = url[1];
  }
  
  public Pagereference save1(){
  System.debug('State_$$$$$'+locationInput.State__c+'@@@@@@'+locationInput.NCES_IDs__c+'^^^^'+locationInput.NCES_IDs__r.name+'&&&'+LocationInput.Is_this_a_K_12_school__c);
  if(LocationInput.Is_this_a_K_12_school__c=='Yes' && locationInput.NCES_IDs__c!=null){
  List<Location__c> relatedLocation = [Select School_State__c,School_Zip__c,School_Street_Address_1__c,School_Street_Address_2__c from Location__c where id=:locationInput.NCES_IDs__c];
    System.debug('Location_Recordd###'+relatedLocation.size());
    if(relatedLocation.size()>0)
     {
      LocationInput.State__c=relatedLocation[0].School_State__c;
       //LocationInput.City__c=relatedLocation[0].City__c;
       LocationInput.Street_Address_1__c=relatedLocation[0].School_Street_Address_1__c;
       LocationInput.Street_Address_2__c=relatedLocation[0].School_Street_Address_2__c;
     
     }    
  }
  PageReference Redirect;
  try{
    if(!Validate())
  return null; 
    If(id!=null && id!=''){
  insert locationInput;
 Redirect = new PageReference('/apex/LocationDetailPage?id='+locationInput.id);
 system.debug('@#@#'+locationInput.id);
    }  
 return Redirect;
    }
Catch(DMLException e){
   ApexPages.addMessages(e);
             System.debug('@@@@@@@@!!!!!'+e.getmessage());
         }
return null;
 }
  
  
  // Save and New button
      public PageReference saveandnew(){
    try {
        if(!Validate())
  return null;   
  insert locationInput;
        sController.save();
        
        Schema.DescribeSObjectResult describeResult = sController.getRecord().getSObjectType().getDescribe();        
     
        PageReference pr = new PageReference('/apex' + '/LocationCreationPage?' + queryString);
  
        pr.setRedirect(true);
        return pr;  

    } catch(System.DMLException e) {
   ApexPages.addMessages(e);
                return null;
    }
} 
  public boolean Validate()
  {
     if(((locationInput.Is_this_a_K_12_school__c == 'Yes') && (locationInput.NCES_IDs__c == null)) || (locationInput.Accessible_for_people_with_disablities__c == true) && (locationInput.Description_of_Accessibility__c == null))
      {
          locationInput.NCES_IDs__c.addError('Enter NCES ID');
          locationInput.NCES_IDs__c.addError('Enter Description of Accesibility');
       /*    locationInput.Name.addError('Enter Name');
           locationInput.Location_Type__c.addError('Enter Location Type');
          locationInput.Supervisor_Name__c.addError('Enter Supervisor Name');
          locationInput.Supervisor_Email__c.addError('Enter Supervisor Email');
         locationInput.Supervisor_Phone_Number__c.addError('Enter Supervisor Phone Number');
           locationInput.Undisclosed_Location__c.addError('Enter Undisclosed Location');
          locationInput.Street_Address_1__c.addError('Enter Street Address 1');
          locationInput.City__c.addError('Enter City');
          locationInput.State__c.addError('Enter State');
          locationInput.Zip__c.addError('Enter Zip');
          locationInput.Projected_Start_Date__c.addError('Enter Projected Start Date');
          locationInput.Projected_End_Date__c.addError('Enter Projected End Date');          
          locationInput.Description_of_Accessibility__c.addError('Enter Description of Accessibility');
          locationInput.Site_Type__c.addError('Enter Site Type');
          locationInput.Station_Type__c.addError('Enter Station Type');
          locationInput.Lodging_Type__c.addError('Enter Lodging Type');
          locationInput.Lodging_Category__c.addError('Enter Lodging Category');
          locationInput.Lodging_Description__c.addError('Enter Lodging Description');
          locationInput.Lodging_Arrival_Date__c.addError('Enter Lodging Arrival Date');
          locationInput.Lodging_Departure_Date__c.addError('Enter Lodging Departure Date');
          locationInput.Distance_to_Location_of_Service__c.addError('Enter Distance to Location of Service');  */
          return false;
           }
           else
        //   return true;
           
           if(Application.NOFA_RFP__r.Focus_Area_and_Objectives_Location__c == true && locationInput.Location_Type__c != 'Member Lodging' )    
    {
if(locationInput.Education__c == null && locationInput.Veterans_Military_Families__c == null && locationInput.Disaster_Services__c == null && 
locationInput.Environmental_Stewardship__c == null && locationInput.Healthy_Futures__c == null && locationInput.Capacity_Building__c == null  && 
locationInput.Economic_Opportunities__c == null)    
{
    
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please enter atleast 1 Focus Area'));
return false;
}
    }
return true;
  }
  
 /* public PageReference populateOtherFields()
{
    Location__c l = [Select NCES_IDs__c, Private_School_Name__c, School_State__c from Location__c where School_ID_NCES__c=: locationInput.NCES_ID__c];
    LocSchool = l.Private_School_Name__c;
    LocState = l.School_State__c;
    return null;

}*/

}