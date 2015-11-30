public with sharing class ContactCreateController3 {



    public ContactCreateController3(ApexPages.StandardController controller) {
        
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
         //Ends here
        
    }
    
public ID acctID{get;set;}
public ID contactID{get;set;}
public string lastname{get;set;}
public Education__C edu{get;set;}
public contact con{get;set;}
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
//Ends here

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
       edubool =true;
       attendeeList = [Select Highest_Level_of_Education__c, College_University__c,Organization_Type__c, Degree_Earned__c , From__c ,To__c,Area_s_of_Study_Degree_Details__c from Education__c where User_Account__c =: con.Id ];
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
 
    }
    public void empdeleteRow() // delete row from employee history
    {
 
        rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
        System.debug('rowbe deleted ' + rowIndex );
        System.debug('rowm to be deleted '+empattendeeList[rowIndex]);
        
        empdel = empattendeeList.remove(rowIndex);
        empdelattendeeList.add(empdel);
 
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
       else
       {
            insert con;
            button_flag = false;
            edu.User_Account__c = con.id;
            system.debug('Contact id-->'+edu.User_Account__c);
            insert edu;

            emp.User_Account__c= con.id;
            system.debug('Contact id-->'+emp.User_Account__c);        
            insert emp;
             
           
           
            attachList = new List<Attachment>();       
            attachList.add(new Attachment(parentId = con.id, name= attach.name, body= attach.body));
            System.debug('attachList list @@@@@@@'+attachList);
            System.debug('empattendeeList list @@@@@@@'+empattendeeList);
            insert attachList;
            //insert empattendeeList;   
              
       }
        PageReference pageref = new PageReference('/'+con.id);
        return pageref ;
       
   }
   
   
  }