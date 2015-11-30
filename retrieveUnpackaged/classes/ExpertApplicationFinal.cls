public with sharing class ExpertApplicationFinal {

    public ExpertApplicationFinal () {

    }




    public ExpertApplicationFinal (ApexPages.StandardController controller) {
        
        con = new contact();
        edu = new Education__c();
        emp= new Employment__c();
        attach = new Attachment(); 
        // Add more Contact to account
         abool =false;
         empbool =false;
         edubool =false;
    
      //  contacts = (Contact)controller.getRecord();
        delattendeeList = new List<Education__C>();
        delattendees = new List<Education__C>();
        
        
        addattendeeList = new List<education__c>();
        //addattendeeList.add(new education__c());
        
        empaddattendeeList = new List<Employment__c>();
      //  empaddattendeeList.add(new Employment__c());
        rend1=false;
         //Ends here
         // save as draft starts here
            educationLists =new List<education__c>();
            education__c dummyLogicModel = new  education__c();   
            educationLists .add(dummyLogicModel); 
            
            employementLists=new List<Employment__c>();
            Employment__c dummyLogicModel1 = new  Employment__c();   
            employementLists.add(dummyLogicModel1); 
            
            
          id=Apexpages.currentPage().getParameters().get('id');
           If(id!=null && id!=''){
            con =[SELECT AccountId,CreatedById,CreatedDate,Date_of_Birth__c,Ethnicity_Type__c,Fax,FirstName,Gender__c,
            HomePhone,How_did_you_hear_about_CNCS_Reviews__c,Id,If_Yes_describe_what_is_needed__c,Is_this_a_Mobile_Number__c,LastName,
            Mailing_City__c,Mailing_State__c,Mailing_Street_Address_1__c,Mailing_Street_Address_2__c,Mailing_Zip_Code__c,
            Middle_Name__c,Phone,Please_Specify__c,Primary_Phone__c,otherphone,Email,
            Race_Type__c,Reasonable_Accommodations_Required__c,Re_Enter_Email__c,Salutation,State_of_Residence__c,Suffix__c,
            Would_you_like_to_receive_texts__c FROM Contact where id=:id];
            system.debug('contact lst -->'+con);
          
            /*addattendeeList =[select id,name,Area_s_of_Study_Degree_Details__c,College_University__c,Degree_Earned__c,From__c,Highest_Level_of_Education__c,Organization_Type__c,To__c,User_Account__c from Education__c where User_Account__c=:con.id];
            
            empaddattendeeList = [select id,name,Area_of_Expertise__c,Experience_Type__c,Expertise__c,From__c,Job_Description__c,Organization_Type__c,To__c,
            User_Account__c,Years_of_Experience__c from Employment__c where User_Account__c=:con.id];
            system.debug('employee lst-->'+empaddattendeeList);*/
           }
           

            // save as draft ends here  
       
        
    }
public String id;    
public ID acctID{get;set;}
public ID contactID{get;set;}
public string lastname{get;set;}
public Education__C edu{get;set;}
public contact con{get;set;}
//set { con = new contact(); }}

public Employment__c emp{get;set;}
public string accname{get;set;}
public Attachment attach{get; set;}  
public List<Attachment> attachList {get; set;}
// Add more Contact to account

public Account accounts;
public Contact contacts;
public Education__c del;
public Employment__c empdel;
public boolean button_flag=false;
public boolean edubutton_flag=false;
public boolean empbutton_flag=false;
public List<Education__c> addattendeeList {get;set;}
public List<Employment__c> empaddattendeeList {get;set;}
public List<Education__c> delattendeeList {get;set;}
public List<Employment__c> empdelattendeeList {get;set;}
public List<Education__c> attendeeList {get;set;}
public List<Employment__c> empattendeeList {get;set;}
public Integer totalCount {get;set;}
public Integer totalCount1 {get;set;}
public Integer rowIndex {get;set;}
public boolean abool{get;set;}
public boolean edubool{get;set;}
public boolean empbool {get;set;}
public Integer rowNum{get;set;}
public Integer rowNum1{get;set;}

public List<Education__c> delAttendees {get; set;} 
public List<Employment__c> empdelAttendees {get; set;} 
Public Boolean rend1{get;set;}
//Ends here
// save as draft starts here
public Boolean displayMsg{get;set;}
Public String rectype{get;set;}
public List<Education__c> educationLists {get; set;}
public List<Employment__c> employementLists {get; set;}

     //Save all the data to contact,education and employee object
    public pagereference save_upsert(){
           
       PageReference Redirect;
                
       if(con.Salutation== null ||con.Salutation=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Salutation' );
            ApexPages.addMessage(myMsg); 
            return null;
         }
         
        
         if(con.FirstName == null ||con.FirstName=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Firstname' );
            ApexPages.addMessage(myMsg); 
            return null;
         }
         
        
         if(con.LastName== null ||con.LastName=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter LastName' );
            ApexPages.addMessage(myMsg); 
            return null;
         }  
          
         if(con.Primary_Phone__c== null ||con.Primary_Phone__c=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Primary Phone' );
            ApexPages.addMessage(myMsg); 
            return null;
         }  
         if(con.Is_this_a_Mobile_Number__c == null ||con.Is_this_a_Mobile_Number__c=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Is this a mobile number?' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.Email == null ||con.Email=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Email' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.Re_Enter_Email__c == null ||con.Re_Enter_Email__c=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Re-Enter Email' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.Mailing_Street_Address_1__c == null ||con.Mailing_Street_Address_1__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Mailing Address' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.Mailing_State__c == null ||con.Mailing_State__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Mailing State' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.Mailing_City__c == null ||con.Mailing_City__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Mailing city' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
               
         
            insert con;
            ID conID = con.ID;
            
            system.debug('name -->'+edu.name); 
            if(edu.name!='' && edu.name!=null)
            {   
            edu.User_Account__c= con.id;
            insert edu;
            }   
            
         
            system.debug('addattendeeListid-->'+addattendeeList);
            if(edubool==true)
            {
            for(Education__c ed:addattendeeList){
                if(ed!=null )
                ed.User_Account__c=con.ID;
                system.debug('ed.User_Account__c-->'+ed.User_Account__c);
                
            }
             system.debug('addattendeeListid-->'+addattendeeList.size());
             
            
            insert addattendeeList;
            system.debug('addattendeeListid-->'+addattendeeList);
            }
           
         
            
            system.debug('Contact id-->'+emp.User_Account__c);        
            if(emp.name!='' && emp.name!=null) 
            {
            emp.User_Account__c= con.id;
            insert emp;
            }
            if(empbool==true)
            {
            for(Employment__c em:empaddattendeeList){
                if(em!=null)
                em.User_Account__c=con.ID;
                system.debug('em.User_Account__c-->'+em.User_Account__c);
                
            }
             Insert empaddattendeeList;
            }
            attachList = new List<Attachment>();       
                     
             try
            {
            attachList.add(new Attachment(parentId = con.id, name= attach.name, body= attach.body));
            System.debug('attachList list @@@@@@@'+attachList);
            System.debug('empattendeeList list @@@@@@@'+empattendeeList);
            if(attachList.size()>0 && attachList[0].name!='' && attachList[0].body!=null)
            insert attachList;
            }
            catch(Exception e)
            {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.error,'Please attach a file in attachments section' );
            ApexPages.addMessage(myMsg); 
            return null;
            
            }
            finally {
            attach.name = null;
            attach.body = null;
            attach = new attachment();
            }
           
            //insert empattendeeList;   
              
       
       
       
        PageReference pageref = new PageReference('/'+con.id);
        return pageref ;
       
   }

    // Save as draft functionality Start from here

    Public PageReference SaveAsDraft()
    {
            System.debug('test save as draft');
            PageReference Redirect;

            try{
            System.debug('Save as draft try method');
            System.debug('Contact Id'+id);
            System.debug('Contact'+con);
     
            If(id!=null && id!='')
            {
            System.debug('Contact Id'+con.id);
            Redirect = new PageReference('/'+con.id);
            update con;
            System.debug('Contact-->'+con);
            return Redirect;
            }

            else{
            
           
            System.debug('Contact-->'+con.lastname);
            insert con;
            system.debug('Contact++'+con);
            Redirect = new PageReference('/'+con.id);
            System.debug('education list size'+educationLists.size());
            
            
            system.debug('Contact id-->'+edu.User_Account__c); 
            if(edu.name!='' && edu.name!=null)
            {
            edu.User_Account__c= con.id;    
            insert edu;
            }
           // if(educationLists.size()>0){       
            System.debug('addattendeeList list size'+addattendeeList.size());
             if(edubool==true)
             {
             for(Education__c ed:addattendeeList){
                if(ed!=null)
                    ed.User_Account__c=con.ID;
                }
            
                insert addattendeeList;
             }
            displayMsg=True; 
            System.debug('education list-->'+educationLists);
            //}
            System.debug('employement list size'+employementLists.size());
            
            
            system.debug('Contact id-->'+emp.User_Account__c); 
            if(emp.name!='' && emp.name!=null)
            {
                emp.User_Account__c= con.id;
                insert emp;
            }
        
            
            //if(employementLists.size()>0){       
            if(empbool==true)
            {
            for(Employment__c em:empaddattendeeList){
                if(em!=null)
                    em.User_Account__c=con.ID;
            }
            
                Insert empaddattendeeList;
            }
            displayMsg=True; 
            System.debug('employement list-->'+employementLists);
           // }
            
           /* if(attachList.size()>0){       
           
            For(attachment att:attachList){
            att.ParentId = con.id;
            att.name=att.name;
            att.body= attach.body;
            }
            Insert attachList;
            displayMsg=True; 
            }
            */
            attachList = new List<Attachment>();       
            
            
             try
            {
            attachList.add(new Attachment(parentId = con.id, name= attach.name, body= attach.body));
            System.debug('attachList list @@@@@@@'+attachList);
            System.debug('empattendeeList list @@@@@@@'+empattendeeList);
            if(attachList.size()>0 && attachList[0].name!='' && attachList[0].body!=null)
            insert attachList;
            }
            catch(Exception e)
            {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.error,'Please attach a file in attachments section' );
            ApexPages.addMessage(myMsg); 
            return null;
            
            }
            return Redirect;
            }
        }
            
            
            
            catch(Exception e){
            System.debug('@@@@@@@@!!!!!'+e.getmessage());
            }

            return null;

          
       }
       
   
       
  // Save as draft functionality ends here
  
  
  public void AddRow1()
    {
       
        edubool=true;
        addattendeeList.add(new education__c());
    }
    
    public void delRow1()
    {
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        addattendeeList.remove(rowNum);   
    }  

    public void AddEmpRow1()
    {
        empbool=true;
        empaddattendeeList.add(new Employment__c());
    }
    
    public void delEmpRow1()
    {
        rowNum1 = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        empaddattendeeList.remove(rowNum1);   
    }   
    
    
    
 
}