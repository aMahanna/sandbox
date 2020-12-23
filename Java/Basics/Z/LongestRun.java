public class LongestRun { 

	public static int getLongestRun(double[] doubleArray) { 
		/*
			Function that gets the longest run for an array
			of type double. Will return 0 if the array is empty 
		*/ 

		// Declare initial counters 	
		int counter = 1;
		int maxCounter = 1; 

		// Evaluates edge case 
		if (doubleArray.length == 0) {
			return 0;
		}

		// Loops through the length of the array
		for (int i = 1; i < doubleArray.length; i++) {

			// If Previous = Following increment counter
			if (doubleArray[i-1] == doubleArray[i]) { 
				counter += 1;

				// Maxcounter replaces counter
				if (counter > maxCounter) {
					maxCounter = counter;
				}

			// Reset counter if run has ended
			} else { 
				counter = 1;
			}

		}

		// Returns the maxcounter
		return maxCounter;
	}
		

	public static int getLongestRun(String[] stringArray) {
		/*
			Function that gets the longest run for an array
			of type String. Will return 0 if the array is empty 
		*/ 
		
		int counter = 1;
		int maxCounter = 1; 

		// Evaluates edge case
		if (stringArray.length == 0) {
			return 0;
		}

		for (int i = 1; i < stringArray.length; i++) {

			// Using the equals method to compare two strings
			if (stringArray[i-1].equals(stringArray[i])) {
				counter += 1;

				// Maxcounter replaces counter
				if (counter > maxCounter) {
					maxCounter = counter;
				}	

			// Resets counter
			} else { 
				counter = 1;
			}

		}

		return maxCounter;
	}

	public static void main(String[] args) {

        double[] a;


        System.out.println("Testing getLongestRun:");
        System.out.println();

        a = new double[] {1.0, 1.0, 2.0, 3.0, 3.0, 3.0, 3.0, 3.0, 6.0, 5.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(getLongestRun(a), 5);

        System.out.println();

        a = new double[] {6.0, 6.0, 7.0, 1.0, 1.0, 1.0, 1.0, 4.5, 1.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(getLongestRun(a), 4);

        System.out.println();

        a = new double[] {6.0, 2.4, 4.0, 8.0, 6.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(getLongestRun(a), 1);

        System.out.println();

        a = new double[] {3.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(getLongestRun(a), 1);

        System.out.println();

        a = new double[] {};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(getLongestRun(a), 0);

        System.out.println();

        a = new double[] {6.0, 6.0, 7.0, 1.0, 1.0, 1.0, 1.0, 4.5, 1.0};

        System.out.print("Test case: ");
        Utils.displayArray(a);

        Utils.assertEquals(getLongestRun(a), 4);

        System.out.println();

        String[] b;

        b = new String[8];

        b[0] = new String("alpha");
        b[1] = new String("alpha");
        b[2] = new String("beta");
        b[3] = new String("charlie");
        b[4] = b[3];
        b[5] = new String("charlie");
        b[6] = new String("delta");
        b[7] = new String("charlie");

        System.out.print("Test case: ");
        Utils.displayArray(b);

        Utils.assertEquals(getLongestRun(b), 3);

        System.out.println();

    }

} 