public class Account{

   private double balance;

   public Account() {
	    this.balance=0;
   }

   public double getBalance() {
     return balance;
   }

   public void deposit(double amount){
      if (amount >= 0) {
         this.balance += amount;
         System.out.println("New balance = " + balance + "$");
      }
   }

   public void withdraw(double amount) throws NotEnoughMoneyException{
      if (amount > balance) {
         throw new NotEnoughMoneyException(amount, balance);
      } else {
         balance -= amount;
         System.out.println("New balance = " + balance + "$");
      }


   }
}