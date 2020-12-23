public class Card {
	
	private int suit, rank; // Intialize private suit and rank variables 
	
	// These constants were made public static to allow the method testDeck in class Test to have access 
	public static final int DIAMOND = 0;
	public static final int CLUB = 1;
	public static final int HEART = 2;
	public static final int SPADE = 3;

	// Constructor to create a card with a suit and rank
	public Card(int suit, int rank) {
		this.suit = suit;
		this.rank = rank;
	}

	// Getter for the Card's suit 
	public int getSuit() {
		return this.suit;
	}

	// Getter for the Card's rank
	public int getRank() {
		return this.rank;
	}

	// Method that returns a string representation of a card 
	public String toString() {
		return "{" + this.suit + "," + this.rank + "}";
	}

	// Method that compares if references of type Card are identical (suit & rank)
	public boolean equals(Object object) {
		if (!(object instanceof Card)) { // Evaluates the edge case
			return false;
		}

		Card other = (Card) object; // Use a typcast to have a reference of type Card for the object

		if (this.suit == other.suit && this.rank == other.rank){  // Compares the equality of two cards
			return true;
		} else {
			return false;
		}

	}
}