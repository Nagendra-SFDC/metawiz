@isTest
private class AzureJitHandlerTest {
    
    @testSetup
    static void setup() {
        // Fetch a valid Profile dynamically
        Profile userProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

        // Create a test user
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com',
            Username = 'testuser' + System.currentTimeMillis() + '@example.com',
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = userProfile.Id
        );
        insert testUser;
    }

    @isTest
    static void testCreateUser() {
        // Use a valid SAML SSO Provider Id (Retrieve dynamically)
        Id samlSsoProviderId = [SELECT Id FROM SAMLSSOConfig LIMIT 1].Id;

        String federationIdentifier = 'testFederationId';
        Map<String, String> attributes = new Map<String, String>{
            'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name' => 'testUser',
            'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress' => 'test@example.com',
            'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname' => 'Test',
            'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname' => 'User'
        };
        String assertion = 'testAssertion';
        
        AzureJitHandler handler = new AzureJitHandler();
        
        Test.startTest();
        User user = handler.createUser(samlSsoProviderId, null, null, federationIdentifier, attributes, assertion);
        Test.stopTest();
        
        System.assertNotEquals(null, user);
        System.assertEquals('test@example.com', user.Email);
        System.assertEquals('Test', user.FirstName);
        System.assertEquals('User', user.LastName);
    }

    @isTest
    static void testUpdateUser() {
        // Retrieve a valid Profile ID
        Profile userProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'test@example.com',
            Username = 'testuser' + System.currentTimeMillis() + '@example.com',
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = userProfile.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;
        
        // Use a valid SAML SSO Provider ID
        Id samlSsoProviderId = [SELECT Id FROM SAMLSSOConfig LIMIT 1].Id;

        String federationIdentifier = 'testFederationId';
        Map<String, String> attributes = new Map<String, String>{
            'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress' => 'updated@example.com',
            'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname' => 'Updated',
            'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname' => 'User'
        };
        String assertion = 'testAssertion';
        
        AzureJitHandler handler = new AzureJitHandler();
        
        Test.startTest();
        handler.updateUser(testUser.Id, samlSsoProviderId, null, null, federationIdentifier, attributes, assertion);
        Test.stopTest();
        
        User updatedUser = [SELECT Id, Email, FirstName, LastName FROM User WHERE Id = :testUser.Id];
        System.assertEquals('updated@example.com', updatedUser.Email);
        System.assertEquals('Updated', updatedUser.FirstName);
        System.assertEquals('User', updatedUser.LastName);
    }
}