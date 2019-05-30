public class AdditionService extends AbstractNanoService {
    public override Object call(Map<String,Object> params) {
        Integer no1,no2;
        try{
            no1 = Integer.valueOf(params.get('no1'));
            no2 = Integer.valueOf(params.get('no2'));
        } catch (Exception exp){
            stderr('AdditionServiceException',exp);
        }
        return no1+no2;
    }
}