public class Cashier {

    // Constant

    private static final String nl = System.getProperty( "line.separator" );

    // Instance variables

    private Queue<Customer> queue;
    private Customer currentCustomer;

    private int totalCustomerWaitTime;
    private int customersServed;
    private int totalItemsServed;

    // constructor

    public Cashier(){
        queue = new ArrayQueue<Customer>();
        
    }

    public void addCustomer( Customer c ) {
        if (c!=null) {
            queue.enqueue(c);
            
        }
        
        
    }

    public int getQueueSize() {
        return queue.size();
    }

    public void serveCustomers( int currentTime ){

        if (queue.isEmpty() && currentCustomer == null) { return;}

        if (currentCustomer == null) {
            currentCustomer = queue.dequeue();
            totalCustomerWaitTime += currentTime - currentCustomer.getArrivalTime();    
            customersServed++;
        }
      
        currentCustomer.serve();
    
        if (currentCustomer.getNumberOfItems() == 0) {
            totalItemsServed += currentCustomer.getNumberOfServedItems();
            currentCustomer = null;
        }
          

    }

    public int getTotalCustomerWaitTime() {
        return totalCustomerWaitTime;
    }

    public int getTotalItemsServed() {
        return totalItemsServed;
    }

    public int getTotalCustomersServed() {
        return customersServed;
    }

    
   
    public String toString() {

        StringBuffer results = new StringBuffer();

        results.append( "The total number of customers served is " );
        results.append( customersServed );
        results.append( nl );

        results.append( "The average number of items per customer was " );
        results.append( totalItemsServed / customersServed );
        results.append( nl );

        results.append( "The average waiting time (in seconds) was " );
        results.append( totalCustomerWaitTime / customersServed );
        results.append( nl );

        return results.toString();
    }
}