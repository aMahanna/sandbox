public class TwoLengthRun { 

	public static boolean hasLengthTwoRun(double[] anArray) {
		/* 
			Function that returns True if the double array
			contains a sequence of two identical values
		*/

		// Loops through the array
		for (int i = 1; i < anArray.length ; i++) {
			// Previous = Current?
			if (anArray[i-1] == anArray[i]) {
				return true; // The answer is found, the loop breaks
			}
		}

		return false; 
	}

	public static void main(String[] args) {

        double[] a;


        System.out.println("Testing hasLengthTwoRun:");
        System.out.println();

        a = new double[] {1.0, 4.0, 3.0, 3.0, 4.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(hasLengthTwoRun(a), true);

        System.out.println();

        a = new double[] {1.0, 2.0, 3.0, 3.0, 3.0, 4.5, 6.0, 5.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(hasLengthTwoRun(a), true);

        System.out.println();

        a = new double[] {1.0, 2.0, 3.7, 4.0, 3.0, 2.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(hasLengthTwoRun(a), false);

        System.out.println();

        a = new double[] {7.7};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(hasLengthTwoRun(a), false);

        System.out.println();

        a = new double[] {2.7, 1.0, 1.0, 0.5, 3.0, 1.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(hasLengthTwoRun(a), true);

    }
}