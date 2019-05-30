public interface NanoService extends System.Callable {
      
    Object  execute(String action,Map<String,Object> context,NanoService callback);
    NanoService  thenExecute(String action,Map<String,Object> context);

    Object  execute(Map<String,Object> context);
    Object  execute(Map<String,Object> context, NanoService callback); 
    NanoService  thenExecute(Map<String,Object> context);
    NanoService  thenExecute(NanoService service);
    
    //execution passed
    NanoService  pass(NanoService service);
    
    //execution failed
    NanoService  fail(NanoService service);
    
    NanoService  ifthen(Boolean condition,NanoService service);
    
    void stdout(Map<String,Object> output);
    void stderr(String key,Object obj);

    NanoService pipe(Object value);

    Object pipe();

    //get most recent execution result
    Object result();
    //set result, this value is automatically piped to next nanoservice
    Object result(Object value);

    //utility methods
    Object execute(Map<String,Object> context, String callback);
    Object  execute(String action,Map<String,Object> context,String callback);
    NanoService fail(String nanoService);
    NanoService  pass(String nanoService);
    NanoService  thenExecute(String nanoService);
}