public class AdditionServiceFailService extends AbstractNanoService {
	public override Object call(Map<String,Object> params) {
        //errors
        for( String errorKey : params.keySet() ) {
        	System.debug(errorKey +' : '+ ((Exception)params.get(errorKey)) );    
        }
        
        return null;
    }
}