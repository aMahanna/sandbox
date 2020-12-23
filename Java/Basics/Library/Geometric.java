public class Geometric extends AbstractSeries {

	private int index = 0;
    private double value = Math.pow(2,index);
    private double lastSerie = 0;

    
    public double next() {

        // implement the method
        double currentSerie = value + lastSerie;
        index++;
        value = Math.pow(2,-(index));
        lastSerie = currentSerie;
        return currentSerie;


    }

}