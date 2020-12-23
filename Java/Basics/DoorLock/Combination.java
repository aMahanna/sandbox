public class Combination {
	// Initalizes the integers to public (it allows access for Class DoorLock)
	public int firstNum, secNum, thirdNum; 

	// Constructor method to set a combination
	public Combination(int first, int second, int third) {
		firstNum = first;
		secNum = second;
		thirdNum = third;
	}

	// Method that compares one combination to another
	public boolean equals(Combination other) {
		if (other == null) { // Evaluates the edge case
			return false;
		} else {
			return firstNum == other.firstNum && secNum == other.secNum && thirdNum == other.thirdNum;
		}
	}

	// Method to display the combination numbers to the user
	public String toString() {
		return firstNum + ":" + secNum + ":" + thirdNum;
	}

}