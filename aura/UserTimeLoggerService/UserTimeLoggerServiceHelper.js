({
	createTimeLog : function(component) {
		var action = component.get("c.createTimeLog");
        action.setCallback(this, function(response) {
        	var state = response.getState();
			if (state === "SUCCESS") {
            	console.log('UserTimeLoggerService started');    
            }
            else if (state === "INCOMPLETE") {
            }
            else if (state === "ERROR") {
                var errors = response.getError();
				console.log( errors );
            }
        });  
        $A.enqueueAction(action);
	},
    
    updateTimeLog : function(component) {
		var action = component.get("c.updateTimeLog");
        action.setCallback(this, function(response) {
        	var state = response.getState();
			if (state === "SUCCESS") {
            	console.log('Updated time entry for the user.');    
            }
            else if (state === "INCOMPLETE") {
            }
            else if (state === "ERROR") {
                var errors = response.getError();
				console.log( errors );
            }
        });  
        $A.enqueueAction(action);
	}
})