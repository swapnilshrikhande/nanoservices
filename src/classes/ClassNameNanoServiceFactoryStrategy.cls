public class ClassNameNanoServiceFactoryStrategy implements NanoServiceFactoryStrategy{
    public Object getInstance(String serviceClassName) {
        System.debug('Instantiating..'+serviceClassName);
    	Type serviceType = Type.forName(serviceClassName);
        return serviceType.newInstance();
    }
}