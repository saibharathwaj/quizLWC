global class AccountService {

    webservice static String createCustomer(String name, String phone, String city) {
        String result='';
        try {
            if(name != null && phone !=null && city !=null){
                Account a= new Account();
                a.name=name;
                a.Phone=phone;
                a.BillingCity=city;
                insert a;
                if(a.Id !=null){
                    result= 'Success';
                }else {
                    result= 'Failure';
                }
            }
           
        }catch(Exception e){
            
        }
         return result;
    }
}