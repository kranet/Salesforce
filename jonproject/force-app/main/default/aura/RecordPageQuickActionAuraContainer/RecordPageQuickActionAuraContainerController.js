({
    doInit: function(component, event, helper) {
        console.log('Runs before component renders');
      },
    handleReceiveMessage : function(component, event, helper) {
        if (event != null) {
            const loadingState = event.getParam('loading');
            if(loadingState !== undefined){
                component.set("v.Loading", loadingState);
            }
        }
    },
    unloadHandler: function(event) {
        console.log('Catches event sent from downstream LWC and closes the super aura component');
        $A.get("e.force:closeQuickAction").fire();
    }
})
