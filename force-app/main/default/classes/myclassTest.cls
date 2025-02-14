@IsTest
public with sharing class myclassTest {
      
        @isTest
        static void testSayHello() {
            String result = myclass.sayHello('Salesforce');
            System.assertEquals('Hello, Salesforce!', result, 'Unexpected greeting message');
        }
    }
                                                                                   