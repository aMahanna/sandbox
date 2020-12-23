public class Timer {
	private int hours;
	private int minutes;
	private int seconds;

	public Timer(){
		hours = 0;
		minutes = 0;
		seconds = 0;
	}

	public void incrementHours(){
		hours++;

		if (hours == 24) {
			hours = 0;
		}

	}

	public void decrementHours(){
		hours--;

		if (hours == -1) {
			hours = 23;
		}
	}

	public int getHours(){
		return hours;
	}

	public void incrementMinutes(){
		minutes++; 

		if (minutes == 60) {
			minutes = 0;
			incrementHours();
		}
	}
	public void decrementMinutes(){
		minutes--;

		if (minutes == -1) {
			minutes = 59;
			decrementHours();
		}
	}

	public int getMinutes() {
		return minutes;
	}

	public void incrementSeconds(){
		seconds++;

		if (seconds == 60) {
			seconds = 0; 
			incrementMinutes();
		}
	}

	public void decrementSeconds(){
		seconds--;

		if (seconds == -1) {
			seconds = 59;
			decrementMinutes();
		}
	}
	
	public int getSeconds(){
		return seconds;
	}

	public String toString () {
		return "Timer "+hours+":"+minutes+":"+seconds;
	}
	
}