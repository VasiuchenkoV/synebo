@isTest
public without sharing class TestDataBuilder {
    public Account buildAccount() {
        return new Account(Name = 'Test');
    }

    public Case buildCase(Id accountId) {
        return new Case(
            Origin = 'Web',
            AccountId = accountId,
            Status = 'Open'
        );
    }
}