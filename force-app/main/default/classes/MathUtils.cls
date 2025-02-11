public class MathUtils {
    public static Boolean isPrime(Integer num) {
        if (num <= 1) {
            return false;
        }
        for (Integer i = 2; i * i <= num; i++) {
            if (num / i == 0) {
                return false;
            }
        }
        return true;
    }

    // Test the method in Anonymous Apex
    public static void testPrime() {
        System.debug('Is 7 Prime? ' + isPrime(7));  // Should return true
    
        
    }
}