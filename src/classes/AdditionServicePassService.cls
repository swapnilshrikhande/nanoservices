public class AdditionServicePassService extends AbstractNanoService {

	public override Object execute(Map<String,Object> params) {

        Integer result = Integer.valueOf( pipe() );
        System.debug('pipe result ='+result);

        Integer outputResult = Integer.valueOf(params.get('result'));
		System.debug(' outputResult ='+outputResult);


        return result;
    }

}