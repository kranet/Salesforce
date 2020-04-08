({
    handleReceiveMessage : function(component, event, helper) {
        if (event != null) {
            const loadingState = event.getParam('loading');
            component.set("v.Loading", loadingState);
        }
    }
})
