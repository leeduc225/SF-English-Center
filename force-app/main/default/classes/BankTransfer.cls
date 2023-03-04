public class BankTransfer extends Pay{
    public String bankCode(){
        return 'leeduc';
    }
    public Double method(){
        Pay pay = new Pay();
        pay.setAmount(10);
        System.debug('check: ' + pay);
        return pay.getAmount();
    }
}