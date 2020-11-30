@IsTest
public class LoadingTestData {

    @TestSetup
    static void setupTestData() {
        Test.loadData(Account.sObjectType, 'TestData_Accounts');
        Test.loadData(Project__c.sObjectType, 'TestData_Projects');
        Test.loadData(Milestone__c.sObjectType, 'TestData_Milestones');
        Test.loadData(Milestone_Task__c.sObjectType, 'TestData_MilestoneTasks');
    }
    
    @isTest
    static void shouldLoadTestData() {
        // in our test data
        List<Account> accounts = [select Id from Account limit 1];
        // there one account record
        System.assert(accounts.size() == 1);
        Account acc = accounts.get(0);
        List<Project__c> projects = [select Id from Project__c where Account__c = :acc.Id];
        // account has one project record
        System.assert(projects.size() == 1);
        List<Milestone__c> milestones = [select Id from Milestone__c where Project__c = :projects.get(0).Id];
        // project has 3 milestone records
        System.assert(milestones.size() == 3);
        List<Milestone_Task__c> milestoneTasks = [
            select Id from Milestone_Task__c 
            where Project__c = :projects.get(0).Id and Milestone__c = :milestones.get(0).Id
        ];
        // each milestone has 2 milestone task records
        System.assert(milestoneTasks.size() == 2);
    }
}