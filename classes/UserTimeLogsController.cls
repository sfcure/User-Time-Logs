public class UserTimeLogsController {
    
    @AuraEnabled 
    public static List<UserTimeLog> getUserTimeLogs(){
        List<UserTimeLog> lstUserTimeLogs = new List<UserTimeLog>();
        //Fetch all the logs in the aggregate query 
        // Fetching last 30 days logs only
        Map<Id, User> mapUsers = new Map<Id, User>([SELECT Id, Name FROM User]);
        for(AggregateResult ar : [SELECT sum(Session_Duration_In_Minutes__c), User__c, Day__c FROM User_Time_Log__c WHERE Day__c = LAST_N_DAYS:30 GROUP BY User__c, Day__c ]){
        	lstUserTimeLogs.add( new UserTimeLog(ar, mapUsers) );	    
        }
        
        lstUserTimeLogs.add(new UserTimeLog('Mark Taylor', System.today(), '3 Hours and 34 Minutes'));
        lstUserTimeLogs.add(new UserTimeLog('Pritam Shekhawat', System.today(), '5 Hours and 14 Minutes'));
        lstUserTimeLogs.add(new UserTimeLog('Hugo Hill', System.today(), '6 Hours and 41 Minutes'));
        lstUserTimeLogs.add(new UserTimeLog('Kris Lee', System.today(), '1 Hour and 20 Minutes'));
        return lstUserTimeLogs;
    }
    
    public class UserTimeLog {
        @AuraEnabled 
        public String userName;
        @AuraEnabled 
        public Date loginDate;
        @AuraEnabled 
        public String loginHours;
        
        public UserTimeLog(AggregateResult ar, Map<Id, User> mapUsers){
            Id userId = (Id) ar.get('User__c');
        	this.userName = mapUsers.get(userId).Name;
            this.loginDate = (Date) ar.get('Day__c');
            Integer min = Integer.valueOf((Decimal) ar.get('expr0'));
            Integer hours = Integer.valueOf(min/60);
            min = Math.mod(min, 60);
            this.loginHours = '';
            if( hours == 1){
            	this.loginHours = '1 Hour and ';    
            }
            else {
            	this.loginHours = hours + ' Hours and ';    
            }
            if( min == 1){
            	this.loginHours += '1 Minute';    
            }
            else {
            	this.loginHours = min + ' Minutes';    
            }
        }
        public UserTimeLog(String userName, Date loginDate, String loginHours ){
        	this.userName =	userName;
            this.loginDate = loginDate;
            this.loginHours = loginHours;
        }
    }
}