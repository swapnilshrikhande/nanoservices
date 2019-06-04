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

        System.debug( ' resultValue = ' + resultValue);
        
        try {
            Object paramService = service( 'AdditionService' )
            .execute( params);
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
            Object paramService_1 = service( 'AdditionService' )
            .execute( 'action', params, addService);
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
            Object paramService_2 = service( 'AdditionService' )
            .execute( 'action', params, 'AdditionService');
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
            NanoService exeDummyService = service( 'AdditionService' )
                .thenExecute( 'action', params );
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
            Object exeDummyService_1 = service( 'AdditionService' )
                .execute( params, 'AdditionService' );
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
            NanoService exeNullService = service( 'AdditionService' )
                .thenExecute();
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
            Object callService = service( 'AdditionService' )
                .call('action', params);
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
            Object executeService = service( 'AdditionService' )
            .execute();
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
            Object pipeService = service( 'AdditionService' )
            .pipe();
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
             service( 'AdditionService' )
            .output( params );
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
            Object paramService_3 = service( 'AdditionService' )
            .execute( params, addService );
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
        	 NanoService executeNanoService = service( 'AdditionService' )
            .thenExecute( addService )
            .pass( addService )
            .fail( addService )
            .ifExecute (true, addService );
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        try {
         	List<String> strLst = new List<String> {'a', 'b'};
        	NanoService executeNanoService_1 = service( 'AdditionService' )
            .execute( strLst , params );
        } catch(Exception excp) {
            System.debug('excp :' + excp);
        }
        
        return resultValue;
    }	
}