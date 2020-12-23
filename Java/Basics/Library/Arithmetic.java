public class Arithmetic extends AbstractSeries {

	private double value = 1;
	private double lastSerie = 0;

    public double next() {
    	double currentSerie = value + lastSerie;
    	value++;
    	lastSerie = currentSerie;
    	return currentSerie;
        
    }

}