public with sharing  class TableService {

    @AuraEnabled(cacheable = true)
    public static List<Account> getLevel1(){
        return [SELECT 
                        name, 
                        phone, 
                        TestLast__c, 
                        level__c 
                        FROM Account 
                        WHERE level__c = 'Level 1'
                        WITH SECURITY_ENFORCED ];
    }

    @AuraEnabled(cacheable = true)
    public static List<Account> getLevel2(){
        return [SELECT 
                        name, 
                        phone, 
                        TestLast__c, 
                        level__c 
                        FROM Account 
                        WHERE level__c = 'Level 2'
                        WITH SECURITY_ENFORCED ];
    }
    @AuraEnabled(cacheable = true)
    public static List<Account> getLevel3(){
        return [SELECT 
                        name, 
                        phone, 
                        TestLast__c, 
                        level__c 
                        FROM Account 
                        WHERE level__c = 'Level 3'
                        WITH SECURITY_ENFORCED ];
    }


    @AuraEnabled
    public static void updateAccounts(List<Account> inputAccounts){
        for (Account acc : inputAccounts) {
            if (acc.level__c == 'Level 1') {
                acc.level__c = 'Level 2';
            } else if (acc.level__c == 'Level 2') {
                acc.level__c  = 'Level 3';
            } else if (acc.level__c == 'Level 3'){
                acc.level__c = 'Level 1';
            }
        update inputAccounts;
    }  
}
}









//     @AuraEnabled(cacheable=true)
//     public static List<map<String, Object>>  getLevel1() { 
//     list <Account> acc = [SELECT id, 
//                                 Name, 
//                                 LastModifiedBy.Name, 
//                                 Phone, 
//                                 Level__c 
//                                 FROM Account 
//                                 WHERE level__c = 'Level 1' 
//                                 WITH SECURITY_ENFORCED];
//     List<map<String, Object>> toLight=new List<map<String, Object>>();
//     for(Account mapa: acc){
//     map<String, Object> m = new Map<String, Object>();
//     m.put('Name', mapa.get('Name'));
//     m.put('Id', mapa.get('Id'));
//     m.put('LastModifiedBy', mapa.LastModifiedBy.Name);
//     m.put('Phone', mapa.get('Phone'));
//     m.put('level__c', mapa.get('level__c'));
//     toLight.add(m);
// }
//     return toLight;
// }

//     @AuraEnabled(cacheable=true)
//     public static List<map<String, Object>>  getLevel2() { 
//     list <Account> acc2 = [SELECT id, 
//                                 Name, 
//                                 LastModifiedBy.Name, 
//                                 Phone, 
//                                 Level__c 
//                                 FROM Account 
//                                 WHERE level__c = 'Level 2' 
//                                 WITH SECURITY_ENFORCED];

//     List<map<String, Object>> toLight2=new List<map<String, Object>>();
//     for(Account mapa: acc2){
//     map<String, Object> m2 = new Map<String, Object>();
//     m2.put('Name', mapa.get('Name'));
//     m2.put('Id', mapa.get('Id'));  
//     m2.put('LastModifiedBy', mapa.LastModifiedBy.Name);
//     m2.put('Phone', mapa.get('Phone'));
//     m2.put('level__c', mapa.get('level__c'));
//     toLight2.add(m2);   
// }
//     return toLight2;
// }  



