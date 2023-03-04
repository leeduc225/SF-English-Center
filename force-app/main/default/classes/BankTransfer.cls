public class BankTransfer extends Pay{
    public String bankCode;
    public void setBankCode(String bankCode){
        this.bankCode = bankCode;
    } 
    
    public String getBankCode(){   
        return this.bankCode; 
    } 

    public override void notification(){
        System.debug('Giao dịch thành công!');
    }
}