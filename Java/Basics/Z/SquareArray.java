public class SquareArray {

	// Function that creates an array with the parameter as its size
	public static int[] createArray(int arraySize) {
		int[] squareArray = new int[arraySize]; // Array filled with 0s

		// Loops through the array and adds the square of each passing index
		for (int i = 0; i < squareArray.length; i++) {
			squareArray[i] = i * i;
		}
		// Returns the array
		return squareArray; 
	}

	// Function that displays all squared numbers of the array
	public static void main(String[] args) {

		// Stores the function call createArray()
		int[] squaredNumbers = createArray(13);

		// Loops through the elements and displays the information
		for (int i = 0; i < squaredNumbers.length; i++) {

			System.out.println("The square of " + i + " is: "+ squaredNumbers[i]);

		}

	}
	
}