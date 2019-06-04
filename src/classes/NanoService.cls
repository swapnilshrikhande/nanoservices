public interface NanoService extends System.Callable {
      
    Object  execute(String action,Map<String,Object> context,NanoService callback);
    NanoService  thenExecute(String action,Map<String,Object> context);

    Object  execute();
    Object  execute(Map<String,Object> context);
    Object  execute(Map<String,Object> context, NanoService callback);


    NanoService  thenExecute();
    NanoService  thenExecute(Map<String,Object> context);
    NanoService  thenExecute(NanoService service);
    
    //execution passed
    NanoService  pass(NanoService service);
    
    //execution failed
    NanoService  fail(NanoService service);
    
    NanoService  ifExecute(Boolean condition,NanoService service);
    
    void output(Map<String,Object> output);
    Map<String,Object> output();
    
    void error(String key,Object obj);
    Map<String,Object> errors();

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
    
    NanoService execute(List<String> algorithmList,Map<String,Object> params);
}