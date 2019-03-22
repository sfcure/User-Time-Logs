@isTest
public class UserTimeLoggerServiceControllerTest {
    
    @isTest 
    static void test_createTimeLog(){
        UserTimeLoggerServiceController.createTimeLog();
        System.assertEquals(1, [SELECT Id FROM User_Time_Log__c].size());
        UserTimeLoggerServiceController.createTimeLog();
    }
	
    @isTest 
    static void test_updateTimeLog(){
        UserTimeLoggerServiceController.createTimeLog();
        UserTimeLoggerServiceController.updateTimeLog();
        System.assertEquals(1, [SELECT Id FROM User_Time_Log__c].size());
        Delete [SELECT Id FROM User_Time_Log__c];
        UserTimeLoggerServiceController.updateTimeLog();
    }
}