public class DoorLock {
	
	// Initalizes variables
	private final int MAX_NUMBER_OF_ATTEMPS = 3;
	private boolean doorOpen, doorActivated;
	private int failedAttempts;
	private Combination doorCombination;

	// Constructor method that sets a DoorLock with a combination
	public DoorLock(Combination c) {
		doorCombination = new Combination(c.firstNum, c.secNum, c.thirdNum);
		failedAttempts = 0; // Resets the number of failed attempts
		doorOpen = false; // The door is closed
		doorActivated = true; // The door is activated

	}

	// Returns if door is open
	public boolean isOpen() {
		return doorOpen;
	}

	// Returns if door is activated
	public boolean isActivated() {
		return doorActivated;
	}

	// Activates door if combination c is equal to the door combination
	public void activate(Combination c) {
		if (doorCombination.equals(c)) {
			doorActivated = true;
		}
	}

	// Method to return if the door is open or not
	public boolean open(Combination combination) {
		if (isActivated()) { // If the door is activated;

			if (doorCombination.equals(combination)) {  // If the user's combination is equal to the doorCombination
				doorOpen = true; // Opens the door 
				failedAttempts = 0; // Resets the number of failed attempts
			} else { // The combination is not the right one;
				failedAttempts++;
				
				if (failedAttempts >= MAX_NUMBER_OF_ATTEMPS) { 
					doorActivated = false; // Deactivates the door if the number of failedAttempts is reached
				}
			}	
		}

		return doorOpen; // Returns if the door is open
		
	}
}