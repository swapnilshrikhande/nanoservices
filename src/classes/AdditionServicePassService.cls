public class AdditionServicePassService extends AbstractNanoService {
	public override Object call(Map<String,Object> params) {
        Integer result = Integer.valueOf(params.get(OUTPUT));
        System.debug('result ='+result);
        return result;
    }
}