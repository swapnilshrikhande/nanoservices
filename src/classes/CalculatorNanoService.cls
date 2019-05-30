public class CalculatorNanoService extends AbstractNanoService {
	
    public override Object call(String action,Map<String,Object> context){
        
        service(action)
            .thenCall(context)
            .pass( service(action+'PassService') )
            .fail( service(action+'FailService') );
        
        return null;
    }
}