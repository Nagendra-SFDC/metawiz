@IsTest
public with sharing class myclassTest {
      
    @IsTest            
    public static void testGetSampleProperties() {
        List<RealEstateProperty.Property> properties = RealEstateProperty.getSampleProperties();
        System.assertEquals(3, properties.size(), 'Expected 3 sample properties');
    }         
<<<<<<< HEAD
                                                                      
=======
                                                            

>>>>>>> 48c07156a9b91f18df09a3eef4abb50e7efff0f4
    @IsTest                                                                                                                     

    public static void testUpdatePropertyPrice() {
        String response = RealEstateProperty.updatePropertyPrice('Villa A', 550000);
        System.assertEquals('Price updated successfully', response, 'Price update failed');

        String responseNotFound = RealEstateProperty.updatePropertyPrice('Unknown Property', 400000);
        System.assertEquals('Property not found', responseNotFound, 'Unexpected property found');
    }
}