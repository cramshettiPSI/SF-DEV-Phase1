public with sharing class RLController {    
    
    public String aFields {get; set;}
    public String aObjType {get; set;}
    public String arecId {get; set;}
    public String arecordType{get; set;}
    public String arelationfield{get; set;}
    public list<ObjectWrapper> objWrapperList{get;set;}
    public list<ColumnWrapper> ColumnWrapList {get;set;}   
    public string pbTitle{get;set;}  
    public String ActionId {get; set;}
    public boolean isRendered{get;set;}
     
   

    public RLController() {
        isrendered = false;              
    }
    
   
    
      public list<ColumnWrapper> ColumnList {
        get {
            if (ColumnWrapList == null) {              
                String tmpStr = aFields;
                String[] aFieldsList= tmpStr.split(',');                  
                ColumnWrapList = LoadColumnList(aObjType, aFieldsList);                              
            }
            return ColumnWrapList;
        }
        set;
    }
    
    public list<ObjectWrapper> objList {
        
        get {
            if(objWrapperList == null){             
                objWrapperList = LoadObjectList(aRecId,aObjType,aRecordType,aFields,arelationfield);
            }           
            return objWrapperList;
        }
        set; /*{
             if(objWrapperList.size()>0){
                isRendered = true;                
            } 
            
             if(arecordType == 'Application')
                pbTitle = 'Applications';
            else if(arecordType == 'Concept Paper')
                pbTitle = 'Concept Papers';
            else if(arecordType == 'Notification of Intent to Apply')
                pbTitle = 'Notification of Intent to Apply';
            system.debug('pbtitle = '+pbtitle);
        }*/
    }
    
    public list<ObjectWrapper> LoadObjectList(String recId, String objType, String recordTypeName,String lfields,String relationfield){
        list<ObjectWrapper> TmpObjList = new list<ObjectWrapper>();                 
        
        String t1 = '\'';
        String t2 = '\'';
        String qry = 'Select Id,';
        qry += lfields;
        qry += '  from '+objType+' where '+relationfield+ ' = '+t1+recId+t2;
        if(recordTypeName!=null){
            Id recordTypeId = getrecordTypeId(objType,recordTypeName);
            qry += ' AND recordTypeId = '+t1+recordTypeId+t2;
        }
        system.debug('qry = '+qry);
        list<sObject> objs = Database.query(qry);
        for(sObject obj: objs){
             TmpObjList.add(new objectWrapper(obj));
        }                  
        return TmpObjList;
    } 
    
      public static list<ColumnWrapper> LoadColumnList(String objType, list<String> fieldslist) {
         
        list<ColumnWrapper> TmpColumnList = new list<ColumnWrapper>();
        
        map<String, Schema.sObjectField> FieldMap = Schema.getGlobalDescribe().get(objType).getDescribe().fields.getMap();
        
        for (String s : fieldslist) {
            Schema.sObjectField FieldObj;
            Schema.DescribeFieldResult DescField;
            String TmpLabel;                                 
            TmpLabel = s;

            // fields of the object retrieve label and permissions, related object fields do not
            FieldObj = FieldMap.get(s);
            if (FieldObj != null) {
                DescField = FieldObj.getDescribe();
                if (DescField != null) {
                    if (DescField.isAccessible() == false) {
                        system.debug('Field: ' + s + ' is not accessable for the user. Field ignored.');
                        continue;
                    }                    
                    TmpLabel = FieldObj.getDescribe().getLabel();                    
                }
            }           
            
                
            TmpColumnList.add(new ColumnWrapper(s, TmpLabel));
        }
        return TmpColumnList;
    }
    
  
    
     public pageReference edit(){                          
        PageReference pg = new PageReference('/apex/ApplicationEditpage?id='+ActionId);
        pg.setRedirect(true);
        return pg;
        
     }
     
     /* public pageReference del(){    
        system.debug('actionId = '+actionId);
        try{
            database.delete(ActionId);
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, e.getMessage()));
        }
        
        return null;
        
     }*/
   
    
    
    
    
    public Id getrecordTypeId(String objType,String recordTypeName){
        map<String, Schema.RecordTypeInfo> rt_map = Schema.getGlobalDescribe().get(ObjType).getDescribe().getRecordTypeInfosByName();
        Schema.Recordtypeinfo rtInfo = rt_map.get(recordTypeName);
        Id desiredRTId = rtInfo.getRecordTypeId();      
        return desiredRTId;
    }
    
    public class ColumnWrapper { 
        public String FieldName {get; set;}
        public String FieldLabel {get; set;}        
        
        public ColumnWrapper(String FieldName, String FieldLabel) {
            this.FieldName = FieldName; 
            this.FieldLabel = FieldLabel;            
        }
    }
    
    
    public class ObjectWrapper { 
        public sObject obj {get; set;}
        public Id objId{get;set;}
        
        public ObjectWrapper(sObject obj) {
            this.obj = obj;           
            this.objId = obj.Id;
        }
    }

}