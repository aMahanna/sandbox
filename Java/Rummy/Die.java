public class Die { // Class Die
	private int diceNum; // Initializes dice number variable

	public Die() { // Constructor to store number from 1 to 6
		diceNum = (int) (Math.random()*6) + 1;
	}

	public int getValue() { // Getter method for diceNum
		return diceNum;
	}

	public int roll() { // Rolls a new number for the dice
		diceNum = (int) (Math.random()*6) + 1;
		return diceNum;
	}

	public String toString() { // Returns a string representation of the dice number
		return "Die {value: " + diceNum + " }";
	}
}