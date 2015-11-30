public with sharing class AccountSavecls {
        public Account actobj{get;set;}
        public AccountSavecls(){
                        actobj=new Account();
        }
        public pagereference saveRec(){
                insert actobj;
                return new pagereference('/'+actobj.id);
                
        }
}