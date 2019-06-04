@isTest
public class CalculatorNanoServiceTest {
    
    @isTest
    public static void testCalculatePass() {
        NanoService instance = new CalculatorNanoService();
        
        Test.startTest();
        Object result = (Object)instance.execute(new Map<String,Object>{'no1' => 1,'no2' => 10});
        Test.stopTest();     
    }
    
    @isTest
    public static void testCalculateFailure() {
        NanoService instance1 = new CalculatorNanoService();
        
        Test.startTest();
        Object result1 = (Object)instance1.execute(null);
        Test.stopTest();
    }
    
    @isTest
    public static void testNanoServiceFactoryMethod() {
     	
		Test.startTest();
        NanoService obj = NanoServiceFactory.getService(ClassNameNanoServiceFactoryStrategy.Class, 'AdditionService');
		Test.stopTest();
    }
}