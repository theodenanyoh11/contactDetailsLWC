@IsTest
public class contactDetailsControllerTest {

    @IsTest
    static void testgetContactDetailMap() { 
    Id idAccountRecordTypeProspect = Test_Environment_Utility.getAccountRecordTypeId('Prospect');
    Territory__c oTerritory1 = Test_Environment_Utility.createBasicTerritory(0, 100, '55372', 'Outside Sales');
        Territory__c oTerritory2 = Test_Environment_Utility.createBasicTerritory(0, 100, '55373', 'Outside Sales');
        Territory__c oTerritory4 = Test_Environment_Utility.createNSTOpenTerritory(101, 100000, 'Outside Sales', '0', '89999');
        //Create open territory
        Territory__c oOpenTerritory = Test_Environment_Utility.createOpenTerritory();
        
        //Create Account with BillingPostalCode=55372 and NumberOfEmployees=50
        Account oAccount = Test_Environment_Utility.createAccount('Test', '55372', 50, idAccountRecordTypeProspect);
                oAccount = [select Id, OwnerId, IsCustomerPortal from Account where Id = :oAccount.Id];
       oAccount.IsCustomerPortal = true;
        
        update oAccount;
    
    Contact c = new Contact();
    c.AccountId = oAccount.Id;
    c.FirstName = 'test';
    c.LastName = 'test';
    c.email = 'test@test.com';
    insert c;
    
	User u = new User(
     ProfileId = [SELECT Id FROM Profile WHERE Name = 'Paycor Customer Portal Privileged Login'].Id,
     LastName = 'last',
     Email = 'puser000@amamama.com',
     Username = 'puser000@amamama.com' + System.currentTimeMillis(),
     CompanyName = 'TEST',
     Title = 'title',
     Alias = 'alias',
     TimeZoneSidKey = 'America/Los_Angeles',
     EmailEncodingKey = 'UTF-8',
     LanguageLocaleKey = 'en_US',
     LocaleSidKey = 'en_US',
     contactId = c.Id
);
        
        Case cs = new Case();
        cs.contactId = c.Id;
        cs.Subject = 'Test';
        cs.AccountId = oAccount.Id;
        insert cs;
        
        Test.startTest();
        Map<String, String> contactDetailsMap = contactDetailsController.getContactDetailMap('Case','ContactId',cs.Id);
        Test.stopTest();
        
    }
}