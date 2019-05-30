public abstract class AbstractNanoService implements NanoService{
    
    public static final String OUTPUT = '__stdout';
    private Object              instream;
    private Object              outstream;
    

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
    	return callback.pipe ( this.outstream = this.call(context) )
                       .call(this.out);
    }

    public virtual Object call(Map<String,Object> context, String callback){
        return call(context, service(callback) );
    }
    
    public virtual Object  call(String action,Map<String,Object> context,NanoService callback){
        return callback.pipe( this.outstream = this.call(action,context) )
                       .call(this.out);
    }

    public virtual Object  call(String action,Map<String,Object> context,String callback){
        return call(action, context, service(callback) );
    }
    
    public virtual NanoService  thenCall(String action,Map<String,Object> context){
        this.outstream = this.call(action,context);
        return this;
    }

	public virtual NanoService  thenCall(Map<String,Object> context){
        this.outstream = this.call(context);
        return this;
    }
    
    //always
    public virtual NanoService  thenCall(NanoService service){
        
        return service.pipe(this.outstream)
                      .thenCall(this.out);
        
    }

    public virtual NanoService  thenCall(String nanoService){
        return thenCall( service(nanoService) );
    }
    
    //execution passed
    public virtual NanoService  pass(NanoService service){
        
        if( error == null ){
            return service.pipe(this.outstream)
                          .thenCall(this.out);
        } else {
            //nop
            return this;
        }
    }

    public virtual NanoService  pass(String nanoService){
        
        if( error == null ){
            return pass( service(nanoService) );
        }

        return this;
    }

    
    //execution failed
    public virtual NanoService fail(NanoService service){
        
        if( error != null ){
            return service.pipe(this.outstream)
                          .thenCall(this.error);       
        } else {
            //nop
            return this;
        }
    }

    public virtual NanoService fail(String nanoService){
        if( error != null ) {
            return fail( service(nanoService) );
        }

        return this;
    }
    
    
    public virtual NanoService  ifthen(Boolean condition,NanoService service){
        
        if( condition ) {
            return service.pipe(this.outstream)
                          .thenCall(this.out);  
        } 
        
        return this;
    }

    public virtual Object pipe(){
        return this.instream;
    }

    public virtual NanoService pipe(Object value){
        this.instream = value;
        return this;
    }


    public virtual void stdout(Map<String,Object> output){
        this.out = output;
    }
    
    public virtual void stderr(String key,Object result){
        error.put(key,result);
        return;
	}

    public Object result() {
        return this.outstream;
    }
    
    public virtual NanoService service(String name){
        return NanoServiceFactory.getService(name);
    }

    //execute an algorithm
    public virtual Object call(List<String> algorithmList){
        NanoService lastService = this;
        for(String algorithm : algorithmList  ) {
            lastService = lastService.pipe( lastService.result() )
                                     .thenCall( service( algorithm ) );
        }
        return lastService.result();
    }
}