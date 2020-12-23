public class Customer {

    // Constant

    private static final int MAX_NUM_ITEMS = 25;

    // Instance variables

    private int arrivalTime;
    private int numberOfItems;
    private int initialNumberOfItems;

    // Constructor

    public Customer( int arrivalTime ) {
        this.arrivalTime = arrivalTime;
        this.initialNumberOfItems =  (int) ( ( MAX_NUM_ITEMS - 1 ) * Math.random() ) + 1;
        numberOfItems = initialNumberOfItems;
    }

    // Access methods

    public int getArrivalTime() {
        return arrivalTime;
    }

    public int getNumberOfItems() {
        return numberOfItems;
    }

    public int getNumberOfServedItems() {
        return initialNumberOfItems - numberOfItems;
    }

    public void serve() {
        if (numberOfItems >= 1) {
            numberOfItems--;
        }
        
    }
}