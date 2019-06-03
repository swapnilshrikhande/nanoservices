public class AdditionServiceFailService extends AbstractNanoService {
	public override Object execute(Map<String,Object> errors) {
        //errors
        for( String errorKey : errors.keySet() ) {
        	System.debug(errorKey +' : '+ ((Exception)errors.get(errorKey)) );
        	error(errorKey,errors.get(errorKey));
        }

        return null;
    }
}