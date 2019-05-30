public class AdditionService extends AbstractNanoService {
    public override Object execute(Map<String,Object> params) {
        Integer no1,no2;
        try {
            no1 = Integer.valueOf(params.get('no1'));
            no2 = Integer.valueOf(params.get('no2'));
            return no1+no2;
        } catch (Exception exp){
            stderr('AdditionServiceException',exp);
        }
        
        return null;
    }
}