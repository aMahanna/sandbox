public class FizzBuzz { // Declare class FizzBuzz
	
	// Function that categorizes numbers divisible by 15, 5 and 3
	public static void main(String[] args) {
		for (int i = 1; i <= 30; i++) { // Loops from 1 to 30

			if (i % 15 == 0) { // Divisible by 15 = FizzBuzz
				System.out.println(i + " FizzBuzz");

			} else if (i % 5 == 0) { // Divisible by 5 = Buzz
				System.out.println(i + " Buzz");

			} else if (i % 3 == 0) { // Divisible by 3 = Fizz
				System.out.println(i + " Fizz");
			}
		}
	}	
}