import java.util.Arrays;

public class ReverseSortDemo {
	public static void main(String[] args){
		char[] unorderedLetters; // Declares/fills char array
		unorderedLetters = new char[]{'b', 'm', 'z', 'a', 'u'};
		reverseSort(unorderedLetters); // Calls the reverse sort method
		// Loops through all chars and displays the reversed order
		for (int i = 0 ; i < unorderedLetters.length; i++ )
			System.out.print(unorderedLetters[i]);

		System.out.println();
	}

	//methode that sorts a char array into its reverse alphabetical order
	public static char[] reverseSort(char[] values){
		// Declares integers for loop
		int i, j, argMin;
		char tmpChar; // Temporary char used for swap

		// Loops twice to sort through the array (alphabetically)
		for (i = 0; i < values.length - 1; i++) {
			argMin = i;
			for (j = i + 1; j < values.length; j++) {
				if (values[j] < values[argMin]) {
					argMin = j;
				}
			}

			tmpChar = values[argMin];
			values[argMin] = values[i];
			values[i] = tmpChar;
  		}

  		// Loops through the array to reverse the order of the sort
		for (i = 0; i < values.length/2; i++) {
     		tmpChar = values[i];
     		values[i] = values[values.length - 1 - i];
     		values[values.length - 1 - i] = tmpChar;
  		}

  		return values;

	}

}