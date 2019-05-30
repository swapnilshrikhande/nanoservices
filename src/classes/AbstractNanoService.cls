public abstract class AbstractNanoService implements NanoService{
    private Object              instream;
    private Object              outstream;
    
    private Map<String,Object> out;
    private Map<String,Object> error;
    
    class AbstractNanoServiceException extends Exception {}
    
    public virtual Object call(String action,Map<String,Object> params){
        return execute(action,params);
    }

    public virtual Object execute(String action,Map<String,Object> params){
        //nop
        throw new AbstractNanoServiceException('execute(string,map<string,object>) method not overriden by the nanoservice');
    }
    
    public virtual Object execute(Map<String,Object> params){
    	throw new AbstractNanoServiceException('execute(map<String,object>) method not overriden by the nanoservice');
    }
    
    public virtual Object execute(Map<String,Object> params, NanoService callback){
    	return callback.pipe ( result( this.execute(params) ) )
                       .execute( stdout() );
    }

    public virtual Object execute(Map<String,Object> params, String callback){
        return execute(params, service(callback) );
    }
    
    public virtual Object  execute(String action,Map<String,Object> params,NanoService callback){
        return callback.pipe( result( this.call(action,params) ) )
                       .execute( stdout() );
    }

    public virtual Object  execute(String action,Map<String,Object> params,String callback){
        return execute(action, params, service(callback) );
    }
    
    public virtual NanoService  thenExecute(String action,Map<String,Object> params){
        result( this.execute(action,params) );
        return this;
    }

	public virtual NanoService  thenExecute(Map<String,Object> params){
        result( this.execute(params) );
        return this;
    }
    
    //always
    public virtual NanoService  thenExecute(NanoService service){
        
        return service.pipe( result() )
                      .thenExecute( stdout() );
        
    }

    public virtual NanoService  thenExecute(String nanoService){
        return thenExecute( service(nanoService) );
    }
    
    //execution passed
    public virtual NanoService  pass(NanoService service){
        
        if( error == null ){
            return service.pipe( result() )
                          .thenExecute( stdout() );
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
            return service.pipe( result() )
                          .thenExecute(this.error);       
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
            return service.pipe( result() )
                          .thenExecute( stdout() );  
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


    public virtual Map<String,Object> stdout(){
        return this.out == null ? this.out = new Map<String,Object>() : this.out ;
    }

    public virtual void stdout(String key,Object value) { 
        stdout().put(key,value);
    }

    public virtual void stdout(Map<String,Object> output){
        this.out = output;
    }
    
    public virtual void stderr(String key,Object result){

        if( error == null )
            error = new Map<String,Object>();

        error.put(key,result);
	}

    public virtual Object result() {
        return this.outstream;
    }

    public virtual Object result(Object value) {
        return this.outstream = value;
    }
    
    public virtual NanoService service(String name){
        return NanoServiceFactory.getService(name);
    }

    //execute an algorithm
    public virtual Object execute(List<String> algorithmList){
        NanoService lastService = this;
        for(String algorithm : algorithmList  ) {
            lastService = lastService.pipe( lastService.result() )
                                     .thenExecute( service( algorithm ) );
        }
        return lastService.result();
    }
}