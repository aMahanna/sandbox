public class ArrayInsertion { // Class Insertion

	// Method InsertArray takes an original array and the desired value to insert at an index position
	public static int[] insertArray(int[] origArray, int indexPos, int newVal) {
		int[] modifiedArray = new int[origArray.length +1]; // Creates an array and increments its size

		// Loops through the modified Array
		for (int i = 0; i < modifiedArray.length; i++) {
			
			if (i < indexPos) { // Copies the values of the original array
				modifiedArray[i] = origArray[i];

			} else if (i == indexPos) { // Once having reached the index position, assigns the desired value 
				modifiedArray[i] = newVal;
			
			} else { // Continues to copy the same values (the index for origArray becomes i-1)
				modifiedArray[i] = origArray[i-1];
			}
			
			
		}

		return modifiedArray;
	}
	
	// Method main to display both arrays
	public static void main(String[] args) {
		// Declares the original array, the desired value and the index position
		int[] origArray = {1, 5, 4, 7, 9, 6};
		int indexPos = 3;
		int newVal = 15;
		int[] newArray = insertArray(origArray, indexPos, newVal); // Creates the new Array with Insert Array method
		
		// Displays original array with a loop
		System.out.println("Array before insertion:"); 
		for (int element: origArray) {
			System.out.println(element);
		}

		// Displays the new array with another loop
		System.out.println("Array after insertion of " 
			+ newVal + " at position " + indexPos + ":");
		for (int element: newArray) {
			System.out.println(element);
		}
		
	}

}