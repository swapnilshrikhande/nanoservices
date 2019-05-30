public class CalculatorNanoService extends AbstractNanoService {
	
    public override Object execute(String action,Map<String,Object> params){
        
        service('AdditionService')
            .thenExecute(params)
            .pass( 'AdditionServicePassService' )
            .fail( 'AdditionServiceFailService' );
       
        return null;
    }	
}