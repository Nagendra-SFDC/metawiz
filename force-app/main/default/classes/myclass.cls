public with sharing class myclass {
    // Inner class to represent a Property
    public class Property {
        public String name;
        public Decimal price;
        public String status;

        public Property(String name, Decimal price, String status) {
            this.name = name;
            this.price = price;

                    this.status = status;

         


        }

    }

    // Method to get a list of sample properties
    public static List<Property> getSampleProperties() {
        List<Property> properties = new List<Property>();
        properties.add(new Property('Villa A', 500000, 'Available'));
        properties.add(new Property('Apartment B', 300000, 'Sold'));
        properties.add(new Property('Penthouse C', 800000, 'Available'));
        return properties;
    }                        
                                                                                                   
    // Method to update the price of a property (by name)
    public static String updatePropertyPrice(String propertyName, Decimal newPrice) {
        List<Property> properties = getSampleProperties();
        for (Property prop : properties) {
            if (prop.name == propertyName) {
                prop.price = newPrice;
                return 'Price updated successfully';
            }          
        }                                                                  
        return 'Property not found';
    }
}