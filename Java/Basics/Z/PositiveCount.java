public class PositiveCount { 

	public static int countPositive(double[] anArray) {
		/*
			Method that counts the number of positive numbers
			in a double array
		*/

		// Initialize counter variable
		int counter = 0;

		// Loops through the elements of the array
		for (double element : anArray) {
			if (element > 0) { // If the element is positive
				counter += 1; // Increment counter
			}
		}

		// Returns the counter
		return counter; 

	}

	public static void main(String[] args) {

        double[] a;

        System.out.println("Testing countPositive:");
        System.out.println();

        a = new double[] {2.0, 3.5, -1.0, -100.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(countPositive(a), 2);

        System.out.println();

        a = new double[] {1.0, 0.0, 22.0, 0.0, 1.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(countPositive(a), 3);

        System.out.println();

        a = new double[] {};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(countPositive(a), 0);

        System.out.println();

        a = new double[] {1.0, 0.0, 22.2, 0.0, 1.0, -10.5};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(countPositive(a), 3);

    }

}