# nanoservices 
- Simple framework to develop modular apex services
- Supports extensible service factory to add custom service factory
- All default methods can be overriden to add custom functionality
- Interoperable with [System.Callable](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_interface_System_Callable.htm)


## Sample Usage

### Extend ```AbstractNanoService```
```
public class CalculatorNanoService extends AbstractNanoService {
	
    public override Object execute(Map<String,Object> params) {
        
        NanoService addService = service('AdditionService')
            .thenExecute( params )
            .pass( 'AdditionServicePassService' )
            .fail( 'AdditionServiceFailService' );

        Object resultValue = addService.result();

        if(  resultValue == null ){
        	System.debug( 'Errors In The Service '+addService.errors());
        }   
    }
}

public class AdditionService extends AbstractNanoService {
    public override Object execute(Map<String,Object> params) {
        Integer no1,no2;
        try {
            no1 = Integer.valueOf(params.get('no1'));
            no2 = Integer.valueOf(params.get('no2'));

            output('result',no1+no2);
            
            return no1+no2;

        } catch (Exception exp){
            error('AdditionServiceException',exp);
        }
        
        return null;
    }
}

public class AdditionServicePassService extends AbstractNanoService {

	public override Object execute(Map<String,Object> params) {

        Integer result = Integer.valueOf( pipe() );
        System.debug('pipe result ='+result);

        Integer outputResult = Integer.valueOf(params.get('result'));
		System.debug(' outputResult ='+outputResult);

        return result;
    }
}


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



```

### Invoke as a normal class or from another NanoService

#### Normal Class : 
```
NanoService instance = new CalculatorNanoService();
instance.execute(new Map<String,Object>{
    'no1' => 1,
    'no2' => 50
});
```

#### Another NanoService : 
```
service('CalculatorNanoService')
      .execute(new Map<String,Object>{
	    'no1' => 1,
	    'no2' => null
      });
```





