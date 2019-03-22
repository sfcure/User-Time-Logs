({
	doInit : function(component, event, helper) {
		helper.createTimeLog(component);
        //execute callApexMethod() again after 60 sec each
        window.setInterval(
            $A.getCallback(function() { 
                helper.updateTimeLog(component);
            }), 60000
        ); 
	}
})