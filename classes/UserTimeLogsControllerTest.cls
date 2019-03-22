@isTest 
public class UserTimeLogsControllerTest {
	@isTest 
    static void test_getUserTimeLogs(){
        UserTimeLoggerServiceController.createTimeLog();
        System.assertEquals(1, UserTimeLogsController.getUserTimeLogs().size());
    }
}