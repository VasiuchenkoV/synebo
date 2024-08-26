public without sharing class CaseTriggerHandler {
    public static void updateAccountFields(Map<Id, Case> oldCases, List<Case> newCases) {
        Set<Id> accountIds = new Set<Id>();
        
        Map<Id, List<Case>> accountWithCases = parseCases(newCases);
        List<Account> accounts = CaseTriggerSelector.getRelatedAccounts(accountWithCases.keySet());
        
        for (Account account : accounts) {
            setAccountFields(account, accountWithCases.get(account.Id), oldCases);
        }
        
        update accounts;
    }
    
    public static Map<Id, List<Case>> parseCases(List<Case> cases) {
        Map<Id, List<Case>> accountWithCases = new Map<Id, List<Case>>();
        
        for (Case actualCase : cases) {
            if (actualCase.AccountId != null) {
                if (accountWithCases.containsKey(actualCase.AccountId)) accountWithCases.get(actualCase.AccountId).add(actualCase);
                else accountWithCases.put(actualCase.AccountId, new List<Case>{actualCase});
            }
        }
        
        return accountWithCases;
    }
    
    public static Account setAccountFields(Account account, List<Case> cases, Map<Id, Case> oldCases) {        
        for(Case actualCase : cases) {
            if (actualCase.Status != 'Closed') {
                account.Open_Cases__c += 1;
                
                if (
                    oldCases.values().size() != 0 &&
                    oldCases.get(actualCase.Id).Status == 'Closed' && 
                    actualCase.Status != 'Closed'
                ) {
                    account.Closed_Cases__c = account.Closed_Cases__c - 1;
                }
            } else {
                if (account.Open_Cases__c != 0) {
                    account.Open_Cases__c = account.Open_Cases__c - 1;
                }
                account.Closed_Cases__c += 1;
            }
        }
        
        return account;
    }
}