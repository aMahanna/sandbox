package main

import "fmt"

func main() {
	var tableau = [7]int{3, 4, 8, 9, 5, 2, 7};

	min,max := findMinMax(tableau[0:]);

	fmt.Print("Slice Minimum: ", min);
	fmt.Println("");
	fmt.Print("Slice Maximum: ", max);
	fmt.Println();

	
}

func findMinMax(slice []int) (min int, max int) {

	if (len(slice) == 0) {
		fmt.Println("ERROR: Slice size is 0, returning the value -1 for min and max variables");
		return -1,-1;
	}

	min = slice[0];
	max = slice[0];

	for _,num := range slice {
		if (num < min) {
			min = num
		}

		if (num > max) {
			max = num;
		}
	}

	return min, max;
	
}


