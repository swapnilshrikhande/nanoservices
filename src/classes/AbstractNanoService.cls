public abstract class AbstractNanoService implements NanoService{
    
    public static final String OUTPUT = '__stdout';
    
    private Map<String,Object> out;
    private Map<String,Object> error;
    
    class AbstractNanoServiceException extends Exception {}
    
    public virtual Object call(String action,Map<String,Object> context){
        //nop
        throw new AbstractNanoServiceException('call(string,map<string,object>) method not overriden by the nanoservice');
    }
    
    public virtual Object call(Map<String,Object> context){
    	throw new AbstractNanoServiceException('call(map<String,object>) method not overriden by the nanoservice');
    }
    
    public virtual Object call(Map<String,Object> context, NanoService callback){
    	 stdout(this.call(context));
         return callback.call(out);
    }   
    
    public virtual Object  call(String action,Map<String,Object> context,NanoService callback){
        stdout(this.call(action,context));
        return callback.call(out);
    }
    
    public virtual NanoService  thenCall(String action,Map<String,Object> context){
        stdout(this.call(action,context));
        return this;
    }

	public virtual NanoService  thenCall(Map<String,Object> context){
        stdout(this.call(context));
        return this;
    }
    
    //always
    public virtual NanoService  thenCall(NanoService service){
        service.stdout(service.call(out));
        return service;
    }
    
    //execution passed
    public virtual NanoService  pass(NanoService service){
        
        if( out != null ){
            service.stdout(service.call(out));
    		return service;        
        } else {
            //nop
            return this;
        }
    }
    
    //execution failed
    public virtual NanoService  fail(NanoService service){
        
        if( error != null ){
            service.stdout(service.call(error));
    		return service;        
        } else {
            //nop
            return this;
        }
    }
    
    
    public virtual NanoService  ifthen(Boolean condition,NanoService service){
        
        if( condition ) {
            service.stdout(service.call(out));
        } 
        
        return this;
    }
    
    public virtual Object stdout(Object result){
        if( out == null )
            out = new Map<String,Object>();
            
        out.put(OUTPUT, result);
        return result;
	}
     
    public virtual void stderr(String key,Object result){
        error.put(key,result);
        return;
	}
    
    public virtual NanoService service(String name){
        return NanoServiceFactory.getService(name);
    }
}