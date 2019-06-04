# nanoservices 
- Simple framework to develop modular apex services
- Supports extensible service factory to add custom service factory
- All default methods can be overriden to add custom functionality

## Sample Usage

```
public class CalculatorNanoService extends AbstractNanoService {
	
    public override Object execute(Map<String,Object> params) {
        
        NanoService addService = service('AdditionService')
            .thenExecute( params )
            .thenExecute( 'AdditionService' )
            .pass( 'AdditionServicePassService' )
            .fail( 'AdditionServiceFailService' );

        Object resultValue = addService.result();

        if(  resultValue == null ){
        	System.debug( 'Errors In The Service'+addService.errors());
        }   
    }
}
```



