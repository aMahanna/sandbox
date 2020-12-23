public abstract class AbstractSeries implements Series {

	private double value;
	private double last;

    public double[] take(int k) {

        // implement the method
    	double[] partialSum = new double[k];
    	
    	for (int i = 0; i < k; i++) {
    		partialSum[i] = this.next();

    	}

    	return partialSum;
        
    }

    public double next() {
    	double current = value + last;
    	last = current;
    	value++;
    	return current;
    }

}