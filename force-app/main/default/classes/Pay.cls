public abstract class Pay {
      public Id account;
      public Double amount;
      public Id classes;
      public Date paymentDate;
      public String paymentMethod;
      public String paymentName;

      public Pay(){

      }

      public Pay(Id account, Double amount, Id classes, Date paymentDate, String paymentMethod, String paymentName){
            this.account = account;
            this.amount = amount;
            this.classes = classes;
            this.paymentDate = paymentDate;
            this.paymentMethod = paymentMethod;
            this.paymentName = paymentName;
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

      public void setClasses(Id classes){
            this.classes = classes;
      } 

      public Id getClasses(){
            return this.classes;
      } 


      public void setPaymentDate(Date paymentDate){
            this.paymentDate = paymentDate;
      } 

      public Date getPaymentDate(){
            return this.paymentDate;
      } 

      public void setPaymentMethod(String paymentMethod){
            this.paymentMethod = paymentMethod;
      } 

      public String getPaymentMethod(){
            return this.paymentMethod;
      } 

      public void setPaymentName(String paymentName){
            this.paymentName = paymentName;
      } 

      public String getPaymentName(){
            return this.paymentName;
      } 

      public abstract void notification();
}