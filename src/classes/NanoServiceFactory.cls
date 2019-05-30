public class NanoServiceFactory {
    
    private static NanoServiceFactoryStrategy nanoServiceFactory;
    
    public static void setServiceStrategy(Type strategyClassType){
        nanoServiceFactory = getFactoryInstance(strategyClassType);
    }
    
    static {
        //default service strategy
        setServiceStrategy(ClassNameNanoServiceFactoryStrategy.Class);
    }
    
    public static NanoService getService(String serviceName){
        return (NanoService) nanoServiceFactory.getInstance(serviceName);
    }

    public static NanoService getService(Type strategyClassType, String serviceName){
        NanoServiceFactoryStrategy serviceFactory = getFactoryInstance(strategyClassType);
        return (NanoService) serviceFactory.getInstance(serviceName);
    }
    
    private static NanoServiceFactoryStrategy getFactoryInstance(Type strategyClassType){
        return (NanoServiceFactoryStrategy)strategyClassType.newInstance();
    }
}