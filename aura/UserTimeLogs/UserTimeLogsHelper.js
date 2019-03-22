({
	fetchData : function(component) {
        var action = component.get("c.getUserTimeLogs");
		action.setCallback(this, function(response) {
        	var state = response.getState();
			if (state === "SUCCESS") {
                component.set("v.data", response.getReturnValue() );
                console.log( response.getReturnValue() );
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