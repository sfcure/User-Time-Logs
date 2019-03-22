({
	doInit: function (component, event, helper) {
        component.set('v.columns', [
            {label: 'User Name', fieldName: 'userName', type: 'text'},
            {label: 'Date', fieldName: 'loginDate', type: 'date'},
            {label: 'Login Hours', fieldName: 'loginHours', type: 'text'}
        ]);

        helper.fetchData(component);
    }
})