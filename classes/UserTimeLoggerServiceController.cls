public class UserTimeLoggerServiceController {
	
    @AuraEnabled 
    public static void createTimeLog() {
        Id userId = UserInfo.getUserId();
        Boolean isSessionActive = false;
        List<User_Time_Log__c> timeEntries = new List<User_Time_Log__c>();
        // Check for the old time entry where logout time was not populate and settle that time entry
        for(User_Time_Log__c utl : [SELECT Id, Logout_Time__c, Active_Session__c FROM User_Time_Log__c WHERE Active_Session__c != NULL AND User__c =:userId ORDER BY LastModifiedDate DESC LIMIT 1]){
            // Check last time-stamp was with in 2 min range
            if( utl.Active_Session__c == UserInfo.getSessionId() ){
            	isSessionActive = true;   
                utl.Logout_Time__c = System.now();
            }
            else {
                utl.Active_Session__c = '';
            }
            
            timeEntries.add(utl);
        }
        
        // Create a new time entry for this login
        if(!isSessionActive){
            timeEntries.add( new User_Time_Log__c( 
                User__c = userId, 
                Login_Time__c = System.now(), 
                Logout_Time__c = System.now(), 
                Active_Session__c = UserInfo.getSessionId()
                ) 
            );
        }
        
        try {
            upsert timeEntries;
            System.debug(timeEntries);
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static void updateTimeLog(){
        Id userId = UserInfo.getUserId();
    	// Check for the old time entry where logout time was not populate and settle that time entry
        User_Time_Log__c timeLog;
        for(User_Time_Log__c utl : [SELECT Id, Active_Session__c FROM User_Time_Log__c WHERE Active_Session__c != NULL AND User__c =:userId ORDER BY LastModifiedDate DESC LIMIT 1]){
            if( utl.Active_Session__c == UserInfo.getSessionId() ) {
                utl.Logout_Time__c = System.now();
            	timeLog = utl;
            }
        }    
        if(timeLog == null){
        	timeLog = new User_Time_Log__c( 
                User__c = userId, 
                Login_Time__c = System.now(), 
                Active_Session__c = UserInfo.getSessionId(),
                Logout_Time__c = System.now()
            );    
        }
        upsert timeLog;
        System.debug(timeLog);
    }
}