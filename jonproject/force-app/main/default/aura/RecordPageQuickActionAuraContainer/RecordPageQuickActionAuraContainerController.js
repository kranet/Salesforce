({
    doInit: function(component, event, helper) {
        helper.initializeEventListener();
      },
    handleReceiveMessage : function(component, event, helper) {
        if (event != null) {
            const loadingState = event.getParam('loading');
            if(loadingState !== undefined){
                component.set("v.Loading", loadingState);
            }
        }
    }
})
