public with sharing class ContactCreateController4 {



    public ContactCreateController4(ApexPages.StandardController controller) {
        
        con = new contact();
        edu = new Education__c();
        emp= new Employment__c();
        attach = new Attachment(); 
        // Add more Contact to account
         abool =false;
         empbool =false;
         edubool =false;
    
        contacts = (Contact)controller.getRecord();
        delattendeeList = new List<Education__C>();
        delattendees = new List<Education__C>();
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


public List<Education__c> delAttendees {get; set;} 
public List<Employment__c> empdelAttendees {get; set;} 
Public Boolean rend1{get;set;}
//Ends here
// save as draft starts here
public Boolean displayMsg{get;set;}
Public String rectype{get;set;}
public List<Education__c> educationLists {get; set;}
public List<Employment__c> employementLists {get; set;}

//save as draft ends here
   public pagereference save(){
       
    insert con;
    button_flag = true;
    
    return null;
       
   }
   
   // Add more Contact to account
    public void addRow()   // add row for education history
    {

       save(); 
       button_flag = true;
       rend1=false;
       edubool =true;
       attendeeList = [Select Highest_Level_of_Education__c,College_University__c, Organization_Type__c, Degree_Earned__c , From__c ,To__c,Area_s_of_Study_Degree_Details__c from Education__c where User_Account__c =: con.Id ];
       system.debug('attendeelist size'+attendeeList );
       totalCount = attendeeList.size();
       attendeeList.add(new Education__C(User_Account__c = con.Id));
       system.debug('attendeelist aftersize'+attendeeList );
          
    }
     public void EmpaddRow() // add row for employee history
    {
       system.debug('contact ID'+con.Id );
       if(con.id!=null)
       {
       button_flag = true;
       empbool = true;
       rend1=false;
       empattendeeList = [Select Area_of_Expertise__c,Experience_Type__c, Expertise__c, From__c , Organization_Type__c ,Job_Description__c,To__c,User_Account__c,Years_of_Experience__c  from Employment__c where User_Account__c =: con.Id ];
       system.debug('attendeelist size'+empattendeeList );
       totalCount1 = empattendeeList.size();
       empattendeeList.add(new Employment__c(User_Account__c = con.Id));
       system.debug('attendeelist aftersize'+empattendeeList );  
       }
       else
       {
       insert con;
       button_flag = true;
       empbool = true;
       rend1=false;
       empattendeeList = [Select Area_of_Expertise__c,Experience_Type__c, Expertise__c, From__c , Organization_Type__c ,Job_Description__c,To__c,User_Account__c,Years_of_Experience__c  from Employment__c where User_Account__c =: con.Id ];
       system.debug('attendeelist size'+empattendeeList );
       totalCount1 = empattendeeList.size();
       empattendeeList.add(new Employment__c(User_Account__c = con.Id));
       system.debug('attendeelist aftersize'+empattendeeList );
          
       }
       
    }
    public void deleteRow() // delete row from education history
    {
 
        rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
        System.debug('rowbe deleted ' + rowIndex );
        System.debug('rowm to be deleted '+attendeeList[rowIndex]);
        del = attendeeList.remove(rowIndex);
        delattendeeList.add(del);
        rend1=true;
        edubool=false;
 
    }
    public void empdeleteRow() // delete row from employee history
    {
        empbool=false;
        rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
        System.debug('rowbe deleted ' + rowIndex );
        System.debug('rowm to be deleted '+empattendeeList[rowIndex]);
        
        empdel = empattendeeList.remove(rowIndex);
       // empdelattendeeList.add(empdel);
        rend1=true;
         
    }
    public PageReference ave()
    {

        upsert attendeeList;
        delete delattendeeList;
        delete delattendeeList;
        delete empdelattendeeList;
        return (new ApexPages.StandardController(accounts)).view();
    } 
    
     
     //Save all the data to contact,education and employee object
    public pagereference save_upsert(){
           
       PageReference Redirect;
       system.debug('button flag'+button_flag);
       if(button_flag)
       {
            System.debug('edubool  @@@@@@@'+edubool );  
            if(edubool == true || edubool == false)
            {
        
                    //System.debug('attendeeList size @@@@@@@'+attendeeList.size());
                 
                    if(attendeeList != null )
                    {
                    edu.User_Account__c = con.id;
                    system.debug('Contact id-->'+edu.User_Account__c);
                    insert edu;
                    insert attendeeList;    
                    }
                    
                    else
                    {
                    edu.User_Account__c = con.id;
                    system.debug('Contact id-->'+edu.User_Account__c);
                    insert edu;
                        
                    }
            }
           System.debug('empbool  @@@@@@@'+empbool );
           if(empbool == true || empbool == false)
            {
                  //  System.debug('empattendeeList size @@@@@@@'+empattendeeList.size());
                    if( empattendeeList!=null )
                    {
                    emp.User_Account__c= con.id;
                    system.debug('Contact id-->'+emp.User_Account__c);        
                    insert emp; 
                    insert empattendeeList; 
                    }       
                    
                    else
                    {
                    emp.User_Account__c= con.id;
                    system.debug('Contact id-->'+emp.User_Account__c);        
                    insert emp; 
                    }
            }
                attachList = new List<Attachment>();       
                attachList.add(new Attachment(parentId = con.id, name= attach.name, body= attach.body));
                insert attachList;
                System.debug('attachList list @@@@@@@'+attachList);
       }
       else if(id!=null && id!='')
       {
        System.debug('Contact Id'+con.id);
            Redirect = new PageReference('/'+con.id);
            update con;
            System.debug('Contact-->'+con);
            return Redirect;
       }
       
       else
       {
                    
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
            button_flag = false;
            
            edu.User_Account__c = con.id;
            system.debug('Contact id-->'+edu.User_Account__c);
            system.debug('education id-->'+edu.id);
            if(edu.id!='' || edu.id!= null)
            insert edu;

            emp.User_Account__c= con.id;
            system.debug('Contact id-->'+emp.User_Account__c);        
            system.debug('employee id-->'+emp.id);
            insert emp;
             
           
           
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
              
       }
       
       
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
           //  con.lastName= 'test';
            If(id!=null && id!='')
            {
            System.debug('Contact Id'+con.id);
            Redirect = new PageReference('/'+con.id);
            update con;
            System.debug('Contact-->'+con);
            return Redirect;
            }

            else{
            
            //update con;
            System.debug('Contact-->'+con.lastname);
            insert con;
            system.debug('Contact++'+con);
            Redirect = new PageReference('/'+con.id);
            System.debug('education list size'+educationLists.size());
            if(educationLists.size()>0){       
            
            For(education__c lm:educationLists){
            lm.User_Account__c = con.id;
            }
            Insert educationLists;
            displayMsg=True; 
            System.debug('education list-->'+educationLists);
            }
            System.debug('employement list size'+employementLists.size());
            if(employementLists.size()>0){       
            
            For(Employment__c em:employementLists){
            em.User_Account__c = con.id;
            }
            Insert employementLists;
            displayMsg=True; 
            System.debug('employement list-->'+employementLists);
            }
            
           /* if(attachList.size()>0){       
           
            For(attachment att:attachList){
            att.ParentId = con.id;
            att.name=att.name;
            att.body= attach.body;
            }
            Insert attachList;
            displayMsg=True; 
            }*/
            
            return Redirect;
            }
            }
            catch(Exception e){
            System.debug('@@@@@@@@!!!!!'+e.getmessage());
            }

            return null;

          
       }
       
   
       
  // Save as draft functionality ends here
   
   
  

     }