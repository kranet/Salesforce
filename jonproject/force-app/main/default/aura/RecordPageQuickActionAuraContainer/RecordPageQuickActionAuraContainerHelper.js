({
    helperMethod : function() {

    },
    beforeUnloadHandler(event) {
        console.log('before unload handler has been called.');
      },
      initializeEventListener: function() {
        window.addEventListener("beforeunload", this.beforeUnloadHandler);
    }
})
