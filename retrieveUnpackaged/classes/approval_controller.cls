public class approval_controller {
public list<item_wrapper> items_to_approve { get; set; }  
    public approval_controller() {
        items_to_approve = new list<item_wrapper>();
        for(ProcessInstanceWorkitem item:[select processinstance.targetobjectid,processinstance.targetobject.name,processinstance.targetobject.type,CreatedDate,OriginalActorId,createdbyId,SystemModstamp from processinstanceWorkitem where actorid = :userinfo.getuserid()]) {
            items_to_approve.add(new item_wrapper(item.processinstance.targetobjectid,item.processinstance.targetobject.name,item.processinstance.targetobject.type,item.createddate,item.OriginalActorId,item.createdbyId,item.SystemModstamp));
        system.debug('Name'+item.processinstance.targetobject.name);
        //system.debug('CreatedDate'+item.CreatedDate);
         system.debug('Type'+item.processinstance.targetobject.type);   
         //system.debug('OriginalActorId'+item.OriginalActorId);
          system.debug('CreatedbyId' +item.createdbyId);
          system.debug('SystemModstamp' +item.SystemModstamp);  
        //system.debug('LastActorId:'+item.processinstance.LastActorId);	
        // system.debug('ActorId:'+item.processinstance.ActorId);   
        }
        }                
        
    public class item_wrapper {
    public id id { get; set; }
        public string name { get; set; }
        public Id ActorId {get; set;}
        public Id LastActorId {get; set;}
        public Id OriginalActorId {get; set;}
        public Id createdbyId {get; set;}
        public string Type {get; set;}
        public string Createdby {get;set;}
        public datetime CreatedDate {get; set;}
        public datetime SystemModstamp {get; set;}
    
    public item_wrapper(id id,string name,string type,datetime CreatedDate,id OriginalActorId,id createdbyId,datetime SystemModstamp) {
            this.id = id;
            this.name = name;
            this.ActorId = ActorId;
        	this.LastActorId=LastActorId;
        	this.createdbyId = createdbyId;
        	this.OriginalActorId=OriginalActorId;
            this.type = type;
        	this.Createdby = Createdby;
            this.CreatedDate = CreatedDate;            
            this.SystemModstamp = SystemModstamp;
    }               
        } 

}