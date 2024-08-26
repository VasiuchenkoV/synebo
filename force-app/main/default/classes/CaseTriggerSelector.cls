public inherited sharing class CaseTriggerSelector {
    public static List<Account> getRelatedAccounts(Set<Id> accountIds) {
        return [
            SELECT Id, Open_Cases__c, Closed_Cases__c
            FROM Account
            WHERE Id IN: accountIds
        ];
    }
}