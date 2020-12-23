public class SecurityAgent { // Class Security Agent
	
	// Initializes variables of class Combination and DoorLock
	Combination agentCombo;
	DoorLock randomDoor;

	private int first,second,third;

	// Constructor method sets a combination for the agent and the same combination for the DoorLock
	public SecurityAgent() {
		// Randomly creates a combination set
		first = (int) (Math.random()*5) + 1;
		second = (int) (Math.random()*5) + 1;
		third = (int) (Math.random()*5) + 1;

		agentCombo = new Combination(first,second,third); // Assigns the combination to the security agent
 
		randomDoor = new DoorLock(agentCombo); // Assigns the security agent's combination to the doorLock
	}


	public DoorLock getDoorLock() {
		return randomDoor;
	}

	// Calls the activate method from the DoorLock class
	public void activateDoorLock() { 
		randomDoor.activate(agentCombo);	
	}
}
