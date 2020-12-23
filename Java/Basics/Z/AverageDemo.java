public class AverageDemo {

	// Method that displays the average of an array of numbers
	public static void main(String[] args){
		double[] valuesArray; // Declares & fills the double array 
		valuesArray = new double[]{100.0,34.0,72.0,56.0,82.0,67.0,94.0};
		// Displays the info with a function call of calculateAverage
		System.out.println("The average is: " + calculateAverage(valuesArray));
	}

	//Method that calculates the average of the numbers in an array
	public static double calculateAverage(double[] values){
		// Initialize resulting average and sum 
		double result = 0; 
		double sum = 0;
		
		// Loops through each element of the array
		for (double element: values) {
			sum += element; // Gathers the total sum of all doubles
		}

		result = sum / values.length; //Finds the average

		return result;
	}

}