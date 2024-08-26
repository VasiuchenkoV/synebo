@isTest
private without sharing class CaseTriggerHandlerTest {
    @TestSetup
    static void setData(){
        TestDataBuilder builder = new TestDataBuilder();
        Account testAccount = builder.buildAccount();
        insert testAccount;

        List<Case> cases = new List<Case>();
        for (Integer i = 0; i <= 199; i++) {
            Case testCase = builder.buildCase(testAccount.Id);
            cases.add(testCase);
        }
		cases[0].Status = 'Closed';
        insert cases;
    }

    @isTest static void testUpdateAccountFieldsOpen() {
        Account account = [
            SELECT Id, Open_Cases__c, Closed_Cases__c
            FROM Account
            WHERE Name = 'Test'
            LIMIT 1
        ];

        Assert.areEqual(199, account.Open_Cases__c);
    }

    @isTest static void testUpdateAccountFieldsClose() {
        Case actualCase = [
            SELECT Id, Status
            FROM Case
            WHERE Status = 'Open'
            LIMIT 1
        ];

        actualCase.Status = 'Closed';
        update actualCase;

        Account account = [
            SELECT Id, Open_Cases__c, Closed_Cases__c
            FROM Account
            WHERE Name = 'Test'
            LIMIT 1
        ];

        Assert.areEqual(2, account.Closed_Cases__c);
        Assert.areEqual(198, account.Open_Cases__c);
    }
    
    @isTest static void testUpdateAccountFieldsReopen() {
        Case actualCase = [
            SELECT Id, Status
            FROM Case
            WHERE Status = 'Closed'
            LIMIT 1
        ];
            
        actualCase.Status = 'Open';
        update actualCase;
            
        Account account = [
            SELECT Id, Open_Cases__c, Closed_Cases__c
            FROM Account
            WHERE Name = 'Test'
            LIMIT 1
        ];
            
        Assert.areEqual(0, account.Closed_Cases__c);
        Assert.areEqual(200, account.Open_Cases__c);
    }
}