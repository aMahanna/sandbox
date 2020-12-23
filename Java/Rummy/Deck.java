import java.util.ArrayList;
import java.util.Collections;

public class Deck {

    private ArrayList<Card> cards; // Initializes the arraylist cards of type Card 

    public Deck() {
        cards = new ArrayList<Card>();
    }

	public Deck(int range) {

    	cards = new ArrayList<Card>(4 * range);

    	for (int suit = 0; suit <= 3; suit++) {
			for (int rank = 1; rank <= range; rank ++) {
				cards.add(new Card(suit, rank));
			}
		}
        
    }

    // Returns the number of cards in this deck.
    int size() {
    	return cards.size();
    }

    // Returns true if and only if this deck has one or more cards.
    boolean hasCards() {
    	return (!cards.isEmpty());
    }

    // Returns the card at the specified position in the deck
    Card get(int pos) {
    	return cards.get(pos);
    }

    // Adds the specified card at the end of this deck (top of the deck)
    void add(Card card) {
    	cards.add(card);
    }

    /* 
    	Appends all the cards from other at the end of this deck. The cards are also removed from
		other. Consequently, the deck designated by other is empty after the call.
    */
    void addAll(Deck other) {
    	cards.addAll(other.cards);
    	other.cards.clear();
    }

    // Removes and returns the last card of this deck.
    Card removeLast() {
        int lastIndex = cards.size() - 1;
    	Card lastCard = new Card(cards.get(lastIndex).getSuit(), cards.get(lastIndex).getRank());
        cards.remove(lastCard);
        return lastCard;
    }

    // Removes and returns the first card of this deck
    Card removeFirst() {
        Card firstCard = new Card(cards.get(0).getSuit(), cards.get(0).getRank());
        cards.remove(firstCard);
        return firstCard;

    }

    /* 
		Removes the first occurrence of the specified card from this deck, if it is present. 
		Returns true if and only if this deck contains the specified card.
   	*/
    boolean remove(Card card) {
    	if (cards.contains(card)) {
    		cards.remove(card);
    		return true;
    	} else {
    		return false; 
    	}
    }

    /* 
		Removes from this deck all of its cards that are contained in the deck designated by the
		parameter other. The cards are not removed from the deck designated by other.
   	*/
    void removeAll(Deck other) {
        for (Card elem: other.cards) {
            cards.remove(elem);
        }
    }

    // Randomly permutes the cards using the shuffle method from the imported class Collections
    void shuffle() { 
    	Collections.shuffle(cards);
    }

    // Removes a maximum of n cards from the end of this deck. The cards are returned in a new deck.
    Deck deal(int n) {
    	Deck dealtCards = new Deck(); // Creates the soon to be returned deck

    	for (int i = cards.size() - n; i < cards.size(); i++) { // Loops through the deck starting from its size - n
    		dealtCards.add(cards.get(i)); // Adds all n cards (from the top of the deck) to the new deck 
    	}

        for (Card elem: dealtCards.cards) { // Removes all the cards that were added to the new deck from the original deck
            cards.remove(elem);
        } 

    	return dealtCards; // Returns the new card 
    }

    // Returns true if and only if this deck contains the specified card.
    boolean contains(Card card) {
    	return cards.contains(card);
    }

    // Returns true if and only if this deck contains all the cards in the specified deck.
    boolean containsAll(Deck other) {
    	return cards.containsAll(other.cards); // The method was already available in the ArrayList method library
    }

    /* 
    	Returns true if and only if this deck is a discardable kind. Specifically, the method returns true if this
		deck has at least two cards and all the cards have the same rank. Otherwise, the method returns false.
	*/
    boolean isKind() {
    	boolean isKind = true; // Boolean variable

    	if (cards.size() >= 2) { // Condition that the user's input contains at least two cards

    		for (int i = 0; i < cards.size()-1; i++) { // Loops through the arraylist
    			
    			if(cards.get(i).getSuit() == cards.get(i+1).getSuit()) { // Verifies that all cards have different suits first 
    				isKind = false; // Returns false if some cards share the same suit and breaks the loop
    				break;
    			}

    			if (((cards.get(i).getRank()) !=((cards.get(i+1).getRank())))) { // Checks if the ranks are not identical 
    				isKind = false; // Returns false if some cards do not share the same rank and breaks the loop
    				break;
    			}
    		}

    	} else { // If the arraylist of cards inputted by the user has a size less than 2, return false
    		isKind = false; 
    	}

    	return isKind; 
	}

	/* 
    	Returns true if and only if this deck is a discardable sequence. Specifically, the method returns true
		if this deck has at least three cards, the cards all have the same suit, the cards form a sequence of consecutive ranks.
		Otherwise, the method returns false.
	*/
	boolean isSeq() {

		boolean isSeq = true; // Boolean variable

    	if (cards.size() >= 3) { // Arraylist input has to be at least of size 3 
    		sortByRank(); // First sorts the inputted arraylist by rank to prevent errors							
    		for (int i = 0; i < cards.size()-1; i++) { // Loops through the inputted number of cards

    			if (cards.get(i).getSuit() != cards.get(i+1).getSuit()) { // Verifies if all cards share the same suit or not
    				isSeq = false;
    				break;
    			}

    			if (cards.get(i).getRank() != cards.get(i+1).getRank()-1) { // Verifies if the cards are sequential
    				isSeq = false;
    				break;
    			} 

    		}

    	} else { // The arraylist size is less than 3 and thus returns false
    		isSeq = false;
    	}

    	return isSeq; // Returns the boolean

	}

	// Method sorts the cards of this deck by suit.
    // Selection sort is used to first sort by suit
    // Bubble sort is then used to re-organize the ranks (there's probably a way more efficient way to do this)
	void sortBySuit() {
		int i, j, argMin; // Index variables
		Card tempCard; // Temporary card used for swap
        Card bubbleCard;

		for (i = 0; i < cards.size() - 1; i++) { // Loops through the cards arraylist
			argMin = i;  
			for (j = i + 1; j < cards.size(); j++) { // Loops through the cards again (minus the first element)
				if (cards.get(j).getSuit() < cards.get(argMin).getSuit()) { // Compares the SUIT of each card
                    argMin = j; // Assigns the index of the smallest suit found to argMin
				}
			}

			// Assigns the smallest suit card to the temporary card variable
			tempCard = cards.get(argMin); 
			// Swaps the position of the starting card (of that loop iteration) with the smallest card using the set method
			cards.set(argMin, cards.get(i)); 
			cards.set(i, tempCard);
  		}

        // Used bubble sort to re-sort by rank for easier readability 
        for (int y = 0; y < cards.size()-1; y++) {
            for (int z = 0; z < cards.size()-y-1; z++)  {
                // Condition that adjacent cards share the same suit but the first card's rank is higher than the following 
                if (cards.get(z).getSuit() == cards.get(z+1).getSuit() && cards.get(z).getRank() > cards.get(z+1).getRank()) { 
                    bubbleCard = cards.get(z+1); // bubbleCard becomes the card with the smaller rank
                    cards.set(z+1, cards.get(z)); // Places the higher ranked card one index ahead
                    cards.set(z, bubbleCard); // Brings the smaller ranked card back by one index
                } 
            }
                
        }
    
	}


	// Method sorts the cards of this deck by rank
	void sortByRank() {
		int i, j, argMin;
		Card tempCard; // Temporary card used for swap
        Card bubbleCard;
		for (i = 0; i < cards.size() - 1; i++) {
			argMin = i;
			for (j = i + 1; j < cards.size(); j++) {
				if (cards.get(j).getRank() < cards.get(argMin).getRank()) { // Compares the RANK of each card
                    
					argMin = j;
				}
			}

			// Makes the same swap as in sortBySuit()
			tempCard = cards.get(argMin);
			cards.set(argMin, cards.get(i));
			cards.set(i, tempCard);
  		}

         // Used bubble sort to re-sort by suit for easier readability 
        for (int y = 0; y < cards.size()-1; y++) {
            for (int z = 0; z < cards.size()-y-1; z++)  {
                // Condition that adjacent cards share the same rank but the first card's suit is higher than the following 
                if (cards.get(z).getRank() == cards.get(z+1).getRank() && cards.get(z).getSuit() > cards.get(z+1).getSuit()) { 
                    bubbleCard = cards.get(z+1); 
                    cards.set(z+1, cards.get(z)); 
                    cards.set(z, bubbleCard);
                } 
            }
                
        }
        

	}

	// Prints the content of this deck in two ways. First, the content is printed by suit. Next, the content is printed by rank.
	void print() {
	
		sortBySuit(); // Sorts by suit
        for (Card elem: cards) {
			System.out.print(" " + elem + " "); // Loops through the arraylist cards and prints each card by calling toString() method
		}

		System.out.println();
        
		sortByRank(); // Re-sorts by rank
		for (Card elem: cards) {
			System.out.print(" " + elem + " "); // Loops through the arraylist cards and prints each card by calling toString() method
		}

		System.out.println();
	}

	/*
        Returns a string representation that contains all the cards in this deck
        Using visibility public "overrides" the toString method in class Card and thus avoids a compile error
    */
	public String toString() { 
		

		String displayDeck = "";
		for (Card elem: cards) {
			displayDeck += elem.toString() + " "; // Loops through the cards and calls the toString method from class Card 
		}

		return displayDeck;

	}

}
