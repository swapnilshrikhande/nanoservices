public interface NanoService extends System.Callable {
    Object  call(Map<String,Object> context);
    Object  call(Map<String,Object> context, NanoService callback);    
    Object  call(String action,Map<String,Object> context,NanoService callback);
    
    NanoService  thenCall(String action,Map<String,Object> context);
    NanoService  thenCall(Map<String,Object> context);
        
    //always
    NanoService  thenCall(NanoService service);
    
    //execution passed
    NanoService  pass(NanoService service);
    
    //execution failed
    NanoService  fail(NanoService service);
    
    NanoService  ifthen(Boolean condition,NanoService service);
    
    Object stdout(Object obj);
    void stderr(String key,Object obj);
}