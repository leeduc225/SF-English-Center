public class Pay {
	public Id account;
    public Double amount;
    public Id classes;
    public Date paymentDate;
    public String paymentMethod;
    public String paymentName;
    
    public Pay(){
        
    }
    
    public void setAccount(Id account){
          this.account = account;
    } 
    
    public String getAccount(){   
         return this.account; 
    } 
    
    public void setAmount(Double amount){
          this.amount = amount;
    } 
    
    public Double getAmount(){
          return this.amount;
    } 
}