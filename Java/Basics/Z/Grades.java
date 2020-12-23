import java.util.*; // Importing for Scanner class

public class Grades { // Declare class
	
	// Function main to ask user for student grades and calls all four methods
	public static void main(String[] args){
		
		// Initiates scanner
		Scanner keyboard = new Scanner(System.in); 
		int i = 0;
		double[] grades = new double[10]; // Creates a double array for 10 grades
		
		System.out.println("Input the grades of 10 Students");
		while (i<10) {
			System.out.print("Student " + i + ": ");
			grades[i] = keyboard.nextDouble(); // Loops through the array and uses user's input as a grade
			i++; 
		}

		System.out.println("Their average is " + calculateAverage(grades) + " %"); // Calls the Average method
		System.out.println("Their median is " + calculateMedian(grades) + " %"); // Calls the Median method
		System.out.println(calculateNumberFailed(grades) + " failing students."); // Calls the Failing method
		System.out.println(calculateNumberPassed(grades) + " passing students."); // Calls the Passing method
		
	}
	
	public static double calculateAverage(double[] notes){
		// Method that calculates the average of the grades
		// Initiates the sum and result variables
		double sum = 0;
		double result = 0; 

		// Loops through the array to collect the sum
		for (double element: notes) {
			sum += element;
		}

		result = sum/notes.length; // Find the average and returns it

		return result;
	}
	
	public static double calculateMedian(double[] notes){
		// Fucntion that calculates the Median of the grades
		
		sort(notes); // First calls the sort method to arrange the grades
		int middle = notes.length/2; // Finds the middle index of the array
		double median; // Initializes the median values

		// If the array length is pair, the median is the average of the two middle values
		if (notes.length % 2 == 0) {
			median = (notes[middle] + notes[middle-1])/2;
		} else { 
			median = notes[middle]; // Else, take the element in the center of the sorted array 
		}

		return median;
	}
	
	public static int calculateNumberFailed(double[] notes){
		// Recognizes the number of failing students

		int counter = 0;
		for (double element: notes) { // Loops through the array
			if (element < 50) {
				counter += 1; // Increments counter if grade is below 50
			}
		}

		return counter;
	}
	
	public static int calculateNumberPassed(double[] notes){
		// Recognizes the number of passing students 
		int counter = 0;
		for (double element: notes) { // Lopps through the array
			if (element >= 50) { 
				counter += 1; // Increments counter if grade is above 50
			}
		}

		return counter;
	}

	public static void sort(double[] xs){
		// Method to sort a double array

		// Variables for loop and index
		int i, j, argMin;
		double tmp; // Temporary double for swapping

		for (i = 0; i < xs.length - 1; i++) { // First loop
			argMin = i;
			for (j = i + 1; j < xs.length; j++) { // Second loop
				if (xs[j] < xs[argMin]) {
					argMin = j;
				}
			}

			// Swapping 
			tmp = xs[argMin];
			xs[argMin] = xs[i];
			xs[i] = tmp;
  		}

	}

}