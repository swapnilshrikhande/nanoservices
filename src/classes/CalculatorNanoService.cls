public class CalculatorNanoService extends AbstractNanoService {
	
    public override Object execute(Map<String,Object> params){
        
        NanoService addService = service('AdditionService')
            .thenExecute(params)
            .pass( 'AdditionServicePassService' )
            .fail( 'AdditionServiceFailService' );

        Object resultValue = addService.result();

        if(  resultValue == null ){
        	System.debug( 'Errors In The Service'+addService.errors());
        }   

        System.debug( ' resultValue = ' + resultValue);

        return resultValue;
    }	
}