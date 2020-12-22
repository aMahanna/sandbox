package main

import "fmt"
import "math/rand"
import "strconv"

type Couteux interface {
	getPrix() float32
	getNom() string
}

type Jeux struct {
	prix float32
	name string
}

type Pommes struct {
	prix float32
	name string
}

func main() {


	var sliceJeux = make([]Couteux, 10)

	var tempJeux Jeux;
	var tempName string;
	var tempPrice float32;

	for i:= 0 ; i < 10; i++ {
		tempName = "jeux" + strconv.Itoa(i);	// Concatenate string "jeux" with the iTH integer to create a name
		tempPrice = rand.Float32() * 10;		// Function rand.Float32() generates a random float from 0 to 1
		tempJeux = Jeux{tempPrice, tempName}; 	// Create iTH Jeux instance 

		sliceJeux[i] = tempJeux; 				// Store tempJeux in sliceJeux at position i
	}

	fmt.Println("All Jeux articles total cost (invididual Jeux prices are randomly generated):") // Display results
	calculPrix(sliceJeux) 
	fmt.Println()

	/* 

		SECOND TYPE (SECOND TEST)
		Create 3 instances of type "Pommes" with assigned prices
		Store them in slicePommes variable
		Call Function calculPrix(slicePommes) to display results

	*/ 

	var slicePommes = make([]Couteux, 3);		// Create slice of size 3
	slicePommes[0] = Pommes{5.0, "macintosh"}	// Assign first, second and third positions with instances of Pommes
	slicePommes[1] = Pommes{10.0, "winesap"}
	slicePommes[2] = Pommes{15.0, "beacon"}

	fmt.Println("All Pommes articles total cost:")	// Display results
	calculPrix(slicePommes)
	fmt.Println()


	/* 

		BOTH TYPES (THIRD TEST)
		Create 2 instances of type "Pommes" with assigned prices and 2 instances of type "Jeux" with assinged prices
		Store them in sliceMixed variable
		Call Function calculPrix(sliceMixed) to display results
	*/

	var sliceMixed = make([]Couteux, 4);		// Create slice of size 4
	sliceMixed[0] = Pommes{7.0, "macintosh"}	
	sliceMixed[1] = Jeux{14.0, "mario"}
	sliceMixed[2] = Pommes{21.0, "beacon"}
	sliceMixed[3] = Jeux{28.0, "battlefield"}

	fmt.Println("Total cost of all MIXED articles:")	// Display results
	calculPrix(sliceMixed)
	fmt.Println()

}

func calculPrix(articles []Couteux) { 	// calculPrix function
	var total float32 = 0; 				// Total cost

	for _, inst := range articles { 	// Loop through elements in articles Slice
		total += inst.getPrix()			// Call getPrix() for each instance implement the Couteux interface
	}
	fmt.Println(total)					// Print total
} 

func (p Pommes) getPrix() float32 { 	// Method 
	return p.prix
}

func (j Jeux) getPrix() float32 { 		// Method
	return j.prix
}

func (j Jeux) getNom() string { 		// Method
	return j.name
}

func (p Pommes) getNom() string { 		// Method
	return p.name
}

