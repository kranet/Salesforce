public with sharing class VFPageControllerExtension{
    ApexPages.StandardSetController setCon;

    public VFPageControllerExtension(ApexPages.StandardSetController controller)
    {
        setCon = controller;
    }
    public String getSelectedAccounts() {
        List<Account> returnList = new List<Account>();
        List<Account> accounts = GenericSObjectSelector.newInstance(Account.sObjectType).selectByIds(Util.setifyList(setcon.getSelected()));
        for(Account looper : accounts) {
            returnList.add(looper);
        }
        return JSON.serialize(returnList);
    }
   
}