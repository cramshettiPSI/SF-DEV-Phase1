public class createaccount {
      
Public String Address{get;set;}
Public String AddressSelected{get;set;}
Public List<SelectOption> options{get;set;}
Public Account pro{get;set;}
Public Account Account{get;set;}
Public Account acct{get;set;}
public boolean displayPopup {get; set;} 
Public Map<String,String> MapOfAddress;
public string userId = ApexPages.currentPage().getParameters().get('uid');

    
    //public Account Org;
    /*public Account account{
    get {
            if (account == null)
                account = new Account();
            return account;
            
        }
        set;
    }*/
    String OrgEin{get;set;}
    //apexpages.standardController sController;
   /*public createaccount(ApexPages.StandardController stdController) {
        sController = stdController;
        this.Org = (Account)stdController.getRecord();
    }*/
    public createaccount(){
      MapOfAddress=new Map<String,String>();
     Account = new Account();
     String strURL=System.URL.getSalesforceBaseUrl().toExternalForm();
      System.debug('Prashant@@@@@@@%%%%^^^^^^'+strURL+'^^^^^^^^^^'+Account+'@@@@@@@@'+acct);
        }
        
        //Addressdoctor method start here
        Public Void GetAddresses()
{


     /*
             Calling webservice method        
             */   
            

// pro=[Select name,Address_1__c,Address_2__c, States__c,Zip1__c from Account where id=:a limit 1];
//System.debug('######Project ID'+pro.id);
AddressdoctorComWebservice5 tes = new AddressdoctorComWebservice5();
AddressdoctorComWebservice5.AddressValidationSoap testsoap = new AddressdoctorComWebservice5.AddressValidationSoap();
AddressdoctorComWebservice5.Parameters parameters = new AddressdoctorComWebservice5.Parameters();
parameters.ProcessMode='INTERACTIVE';
AddressdoctorComWebservice5.ArrayOfAddress addresses = new AddressdoctorComWebservice5.ArrayOfAddress();
AddressdoctorComWebservice5.Address address1 = new AddressdoctorComWebservice5.Address();
addresses.address = new List<AddressdoctorComWebservice5.Address>();
AddressdoctorComWebservice5.ArrayOfString testArray = new AddressdoctorComWebservice5.ArrayOfString();
testArray.string_x = new List<String>{'ABC'};
//address1.Organization = testArray;
//address1.RecordId= a;

AddressdoctorComWebservice5.ArrayOfString  testArray1 = new AddressdoctorComWebservice5.ArrayOfString();

//testArray1.string_x = new List<String>{'Test@gmail.com'};
//address1.Email = testArray1; 

System.debug('Prashant^^^^^^^^^^'+Account.States__c+'########'+Account.Address_1__c);

AddressdoctorComWebservice5.ArrayOfString  testArray2 = new AddressdoctorComWebservice5.ArrayOfString();
testArray2.string_x=new List<String>{Account.States__c};
address1.Province= testArray2; 

AddressdoctorComWebservice5.ArrayOfString  testArray3 = new AddressdoctorComWebservice5.ArrayOfString();
testArray3.string_x=new List<String>{'United States'};
address1.Country= testArray3; 

AddressdoctorComWebservice5.ArrayOfString  testArray4 = new AddressdoctorComWebservice5.ArrayOfString();
testArray4.string_x=new List<String>{Account.Address_1__c};
//testArray4.string_x=new List<String>{'SUNRISE VALLEY DR STE'};
address1.HouseNumber= testArray4; 

AddressdoctorComWebservice5.ArrayOfString  testArray5 = new AddressdoctorComWebservice5.ArrayOfString();
testArray5.string_x=new List<String>{Account.Address_2__c};
address1.Street= testArray5; 

AddressdoctorComWebservice5.ArrayOfString  testArray6 = new AddressdoctorComWebservice5.ArrayOfString();
testArray6.string_x=new List<String>{Account.Zip1__c};
address1.PostalCode= testArray6; 

addresses.Address.add(address1);
//System.debug('ValidateAddress'+address1.Organization+'@@@@@'+address1.Country+'%%%%'+address1.PostalCode);
AddressdoctorComWebservice5.ArrayOfEnrichment enrichments = new AddressdoctorComWebservice5.ArrayOfEnrichment();
AddressdoctorComWebservice5.ServiceParameters ServiceParam = new AddressdoctorComWebservice5.ServiceParameters();
//ServiceParam.JobToken='b89be474-318c-4da3-87c2-f15b2e43c2cb';
parameters.ServiceParameters = ServiceParam;

AddressdoctorComWebservice5.Response res = testsoap.Process('161683','Infa123',parameters,addresses,enrichments);
System.debug('Prashant$$$$$$$^^^^^'+res.statuscode+'$$$$'+res.StatusMessage);
AddressdoctorComWebservice5.ResultData[] ResData=res.results.result[0].ResultDataSet.ResultData; // Added

System.debug('#######ResultSet'+res.results.result.size());
System.debug('#######ArrayOfResultSet'+res.results.result[0].ResultDataSet.ResultData.size()+'@@@@@@'+ResData.size());
System.debug('#######ArrayOfResultSet_ResultNumber'+res.results.result[0].ResultDataSet.ResultData[0].ResultNumber);
options = new List<SelectOption>();
For(AddressdoctorComWebservice5.ResultData rd : ResData)
{
//System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.Organization.string_x+'@@'+rd.address.Department.string_x+'@@'+rd.address.Contact.string_x+'@@'+rd.address.Building.string_x+'@@'+rd.address.SubBuilding.string_x+'@@'+rd.address.Street.string_x+'@@'+rd.address.HouseNumber.string_x+'@@'+rd.address.DeliveryService.string_x+'@@'+rd.address.Locality.string_x+'@@'+rd.address.AddressComplete);
//System.debug('#######ArrayOfResultSet_ResultNumber_iterate_Fields'+rd.address.PreferredLocality.string_x+'@@'+rd.address.PostalCode.string_x+'@@'+rd.address.Province.string_x+'@@'+rd.address.Country.string_x+'@@'+rd.address.Residue.string_x+'@@'+rd.address.RecipientLines.string_x+'@@'+rd.address.DeliveryAddressLines.string_x+'@@'+rd.address.CountrySpecificLocalityLine.string_x+'@@'+rd.address.FormattedAddress.string_x);
System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.FormattedAddress.string_x);
options.add(new SelectOption(rd.address.AddressComplete,rd.address.AddressComplete)); 
MapOfAddress.put(rd.address.AddressComplete,rd.address.PostalCode.string_x[0]);
}

}

public PageReference Submit() {
PageReference PR;

try{
If(Address!=null){

String Postalcode=MapOfAddress.get(Address);
List<String> strlist=Address.split(';');
If(strlist.size()>0){
displayPopup = false;
Account.Address_1__c=strlist[0];
Account.Zip1__c=Postalcode;
//Insert Account;
//PR = new PageReference('/'+Account.id);
//PR = new PageReference('/apex/CommunitiesSelfRegConfirm');
}
}
else{
ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Warning,'Please select one option to update' );
ApexPages.addmessage(msg);
}
//return PR;
return null;//added
}

catch(Exception e){
System.debug('Exception Message'+e.getMessage());
}

        return null;
    }
    
Public PageReference Save(){
PageReference PR;
 
try{
//Insert Account;
//PR = new PageReference('/'+Account.id);
//PR = new PageReference('/apex/CommunitiesSelfRegConfirm');
//return PR;
return null;//added
} 
catch(Exception e){
System.debug('Exception Message'+e.getMessage());
}

 return null;
}    
    
Public PageReference PageRedirect(){
//List<account> acco=[Select id,Phone1__c,Legal_Name__c,Organization_Type__c,Address_1__c,City__c,States__c,Zip1__c,Phone__c from account];
//if(acco.size()>0)
//System.debug('Exception Mess33333age'+acco.size());
displayPopup = true;
GetAddresses();
return null;

//PageReference pageref = new PageReference('/apex/newValidateAddress');
//return pageref;
 
return null;
}  


 public void closePopup() {        
        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }

        
        
        
        
        
        
        
        
        
       
    public In_direct__c indirectcost{get;set;}    
    public pagereference create(){
        pagereference pr =null;
        try{
            system.Debug(LoggingLevel.Info,+account.Ein__c);
            List<Account> lstOrg =[Select id,Ein__c from Account where Ein__c =:account.Ein__c];
            if(lstOrg!=null && lstOrg.size()>0){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: The Organization you are trying to create already exists'));
            }else{
                system.Debug('account-------'+account);
                account.ownerId = '005t0000000M0WW';
                insert account;
                Contact newContact =[Select id,AccountId from Contact where Id =:userId limit 1];
                newContact.AccountId = account.Id;
                update newContact;
                pr =new pagereference('/apex/CommunitiesSelfRegConfirm');
            }
        }
        catch(exception e)
        {
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'======'+e));
        }
        return pr;
    
    }

    
    public pagereference Cancelrecord(){
       pagereference pr  =new pagereference('/apex/Login_Page'); 
       return pr;
    
    }
}