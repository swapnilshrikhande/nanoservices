public class AdditionServicePassService extends AbstractNanoService {
	public override Object execute(Map<String,Object> params) {
        Integer result = Integer.valueOf( pipe() );
        System.debug('result ='+result);
        return result;
    }
}