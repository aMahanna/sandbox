public class Game {
	// Initalizes main deck (NOT strangeDeck), hand and dice 
	private Deck mainDeck; 
	private Deck playerHand;
	private Die dice; 
	
	// Constructor that creates the main deck, the player's hand and the dice
	public Game(int rankNum) {
		mainDeck = new Deck(rankNum);
		playerHand = new Deck();
		dice = new Die();
	}

	

	// Method play implements the logic of the game
	public void play() {
		Deck strangeDeck; // strangeDeck will be used for the game
		Deck meldDeck; // meldDeck is the player's card inputs when asked for melds
		Card discardChoice; // discardChoice is the card selected to discard when dice rolls 1
		int diceNum; // Initializes dice number
		int roundNumber = 1; // Initializes round number

		strangeDeck = new Deck(mainDeck.size()/4); // Creates the strange deck and shuffles it
		strangeDeck.shuffle();

		playerHand.addAll(strangeDeck.deal(7)); // Deals 7 cards to the player from the top of the strange Deck
		
		System.out.println("Here is your hand printed in two ways:");
		playerHand.print();
		
		while(playerHand.hasCards()) { // Primary loop (This is "Step 2")
			System.out.println();
			System.out.println("WELCOME TO ROUND " + roundNumber);
			
			if (strangeDeck.hasCards()) { // Verifies that the strange deck is not empty

				diceNum = dice.roll(); 
				System.out.println("You rolled the dice: " + diceNum); // Rolls the dice and displays the number

				if (diceNum == 1) { // Initiates the discard selection if the dice number is 1
					System.out.println("Discard a card of your choosing");
					discardChoice = Utils.readCard(); 

					while(!playerHand.contains(discardChoice)) { // Makes sure that the card selected is in the player's hand
							System.out.println("That card is not in your hand");
							discardChoice = Utils.readCard(); 
					}

					playerHand.remove(discardChoice); // Removes the selected card from the hand and displays the hand again
					System.out.println("Here is your new hand printed in two ways:");
					playerHand.print();

				} else { // Here diceNum is in between 2 and 6

					if (strangeDeck.size() <= diceNum) { // Checks if there are less cards in the strange deck than the diceNum
						System.out.println("The rest of the deck has been added to your hand.");
						playerHand.addAll(strangeDeck.deal(strangeDeck.size()));
						System.out.println("Here is your new hand printed in two ways:");
						playerHand.print();

					} else { // Deals the amount rolled to the player
						System.out.println(diceNum + " cards have been added to your hand.");
						playerHand.addAll(strangeDeck.deal(diceNum));
						System.out.println("Here is your new hand printed in two ways:");
						playerHand.print();
					}	

					// Asks user if they have a meld to discard
					String message = new String("Yes or no, do you have a sequence of three or more cards of the same suit or two or more of a kind?");
					System.out.println();
					boolean hasMeld = Utils.readYesOrNo(message);
					while (hasMeld) { // Loop to allow user to continuously input all his melds 
						meldDeck = Utils.readCards("Enter your meld");

						while (!(playerHand.containsAll(meldDeck))) { // Makes sure that all meld cards are in the user's hand
							System.out.println("Invalid input. Not all cards are in hand.");
							meldDeck = Utils.readCards("Re-enter your meld");
						}

						if (meldDeck.isKind() || meldDeck.isSeq()) { // Evaluates if the meldDeck forms a meld or not
							playerHand.removeAll(meldDeck); // Removes all cards in meldDeck from playerHand
							System.out.println("Here is your new hand printed in two ways:"); 
							playerHand.print();
						} else { // Let's the user know that their input does not form a meld
							System.out.println("Invalid input. These cards do not form a meld."); 
						}

						hasMeld = Utils.readYesOrNo(message); // Asks the user if he has another meld to repeat the loop

					}
				}

			} else { // The strangeDeck is now empty

				// Allows the user to discard the remaiming un-meldable cards
				System.out.println("Discard a card of your choosing"); 
				discardChoice = Utils.readCard(); 
					
				while(!playerHand.contains(discardChoice)) { // Verifies edge-case again
					System.out.println("That card is not in your hand");
					discardChoice = Utils.readCard(); 
				}

				playerHand.remove(discardChoice); 
				System.out.println("Here is your new hand printed in two ways:");
				playerHand.print();
			}
			
			// The round is over and the primary loop repeats --> playerHand.hasCards()
			System.out.println("ROUND " + roundNumber + " ENDED.");
			roundNumber++;
		}

		// The primary loop ends - the player finished the game
		System.out.println("CONGRATULATIONS! YOU COMPLETED THE GAME IN " + roundNumber + " ROUNDS.");


	}

}

