public abstract class AbstractNanoService implements NanoService{
    private Object              instream;
    private Object              outstream;
    
    private Map<String,Object> out;
    private Map<String,Object> errorMap;
    
    class AbstractNanoServiceException extends Exception {}
    
    public virtual Object call(String action,Map<String,Object> params){
        return execute(action,params);
    }

    public virtual Object execute(){
        throw new AbstractNanoServiceException('execute() method not overriden by the nanoservice');
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
                       .execute( output() );
    }

    public virtual Object execute(Map<String,Object> params, String callback){
        return execute(params, service(callback) );
    }
    
    public virtual Object  execute(String action,Map<String,Object> params,NanoService callback){
        return callback.pipe( result( this.call(action,params) ) )
                       .execute( output() );
    }

    public virtual Object  execute(String action,Map<String,Object> params,String callback){
        return execute(action, params, service(callback) );
    }


    public virtual NanoService  thenExecute(){
        result( this.execute() );
        return this;
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
                      .thenExecute( output() );
        
    }

    public virtual NanoService  thenExecute(String nanoService){
        return thenExecute( service(nanoService) );
    }
    
    //execution passed
    public virtual NanoService  pass(NanoService service){
        
        if( errorMap == null ){
            return service.pipe( result() )
                          .thenExecute( output() );
        } else {
            //nop
            return this;
        }
    }

    public virtual NanoService  pass(String nanoService){
        
        if( errorMap == null ){
            return pass( service(nanoService) );
        }

        return this;
    }

    
    //execution failed
    public virtual NanoService fail(NanoService service){
        
        if( errorMap != null ){
            return service.pipe( result() )
                          .thenExecute( errors() );       
        } else {
            //nop
            return this;
        }
    }

    public virtual NanoService fail(String nanoService){
        if( errorMap != null ) {
            return fail( service(nanoService) );
        }

        return this;
    }
    
    
    public virtual NanoService  ifExecute(Boolean condition,NanoService service){
        
        if( condition ) {
            return service.pipe( result() )
                          .thenExecute( output() );  
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


    public virtual Map<String,Object> output(){
        return this.out == null ? this.out = new Map<String,Object>() : this.out ;
    }

    public virtual void output(String key,Object value) { 
        output().put(key,value);
    }

    public virtual void output(Map<String,Object> output){
        this.out = output;
    }
    
    public virtual void error(String key,Object result){

        if( errorMap == null )
            errorMap = new Map<String,Object>();

        errorMap.put(key,result);
	}

    public virtual Map<String,Object> errors(){
        return errorMap;
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
    public virtual NanoService execute(List<String> algorithmList,Map<String,Object> params){
        NanoService lastService = this;
        NanoService currentService;
        for(String algorithm : algorithmList  ) {

            currentService = service(algorithm);

            lastService = currentService.pipe( lastService.result() )
                                        .thenExecute( lastService == this ? 
                                                        params 
                                                      : lastService.output() 
                                                    );

            if( lastService.errors() != null )
                break;
        }

        return lastService;
    }
}