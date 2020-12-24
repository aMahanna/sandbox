package main

import "time"
import "fmt"
import "bufio"
import "os"

type Play struct {
	name string 		
	purchased []Ticket
	ticketSales *int32
	showStart time.Time
	showEnd time.Time
}

type Comedy struct {
	laughs float32 // Default 0.2
	deaths int32 // Default 0
	play Play // Tartuffe, 0, Mar 3rd at 4:00pm, Mar 3rd at 5:20pm
}

type Tragedy struct {
	laughs float32 // Default 0.0
	deaths int32 // Default 12
	play Play // Macbeth, 0, April 16th at 9:30am, April 16th at 12:30pm
}

type Show interface {
	getName() string
	getShowStart() time.Time
	getShowEnd() time.Time
	addPurchase(*Ticket) bool
	isNotPurchased(*Ticket) bool

	// Four methods added as helper functions
	hasEmptySeats(int, int32, int32) bool 
	showEmptySeats(int, int32, int32)
	getSalesNum() int32
	displayShowInfo(int32)
}

type Seat struct {
	number int32 // DEFAULT 1
	row int32    // DEFAULT 1
	cat *Category
}

type Category struct {
	base float32  // DEFAULT 25.0
	name CategoryName
}

// CONSTANT Category Names 
type CategoryName string
const (
   Prime 	CategoryName = "Prime"
   Standard CategoryName = "Standard"
   Special	CategoryName = "Special"
)

type Ticket struct {
	customer string
	siege *Seat
	s *Show
}

type Theatre struct {
	seats []Seat
	shows []Show
}


/* 

			**********************************							Default Methods are HERE                      ********************************
*/ 
func NewSeatDefault() *Seat {
       var s Seat
       s.number = 1
       s.row = 0 						// In this case, Row "1" Implies Row at index 0 
       s.cat = NewCategoryDefault()
       return &s
}


func NewCategoryDefault() *Category {
	return &Category{25.0, Prime}
}

func NewComedyDefault() Comedy {

	var defaultStart time.Time = time.Date( 												// Create comedy DEFAULT start time and end time								
        2020, 3, 3, 16, 00, 00, 000000000, time.UTC)
    var defaultEnd time.Time = time.Date(
       2020, 3, 3, 17, 20, 00, 000000000, time.UTC)

    var ticketSales int32 = 0
	ticketSalesPTR := &ticketSales
	defaultPlay := Play{"Tartuffe", make([]Ticket, 100), ticketSalesPTR, defaultStart, defaultEnd}
	return Comedy{0.2, 0, defaultPlay}
}

func NewTragedyDefault() Tragedy {

	defaultStart := time.Date(																// Create tragedy DEFAULT start time and end time
        2020, 4, 16, 9, 30, 00, 000000000, time.UTC)
    defaultEnd := time.Date(
       2020, 4, 16, 12, 30, 00, 000000000, time.UTC)

	var ticketSales int32 = 0
	ticketSalesPTR := &ticketSales
	defaultPlay := Play{"Macbeth", make([]Ticket, 100), ticketSalesPTR, defaultStart, defaultEnd}
	return Tragedy{0, 12, defaultPlay}
}

/* **************************************************************************************************************** */

func main() {

	var comedyStart time.Time = time.Date( 													// Create comedy start time and end time
        2020, 3, 3, 19, 30, 00, 000000000, time.UTC)
    var comedyEnd time.Time = time.Date(
       2020, 3, 3, 22, 00, 00, 000000000, time.UTC)

	var comedyShow Show = NewComedy(0.2, 0.0, "Tartuffe", comedyStart, comedyEnd) 			// Create comedy with non-default values
	

	tragedyStart := time.Date(																// Create tragedy start time and end time
        2020, 4, 10, 20, 00, 00, 000000000, time.UTC)
    tragedyEnd := time.Date(
       2020, 4, 10, 23, 00, 00, 000000000, time.UTC)

	var tragedyShow Show = NewTragedy(0.0, 12, "Macbeth", tragedyStart, tragedyEnd)			// Create tragedy with non-default values


	showSlice := make([]Show, 2)															// Create a slice of shows (2)
	showSlice[0] = comedyShow																// Add Comedy to showSlice
	showSlice[1] = tragedyShow																// Add Tragedy to showSlice

	/* ************************************ Build Theatre  *********************************************** */

	var numSeats int32 = 25														// Use (15, 3) if you would like to test sold-out features					
	var numRows int32 = 5

	var mainTheatre = NewTheatre(numSeats, numRows, showSlice)								// Create a theatre with 25 seats, 5 rows
	mainTheatre.BuildTheatre(numSeats, numRows)												// Build theatre (create seat instances)

	var seatsPerRow int32 = numSeats / numRows 					
	var numStandardRows int32 = numRows - 2 			// Number of Standards Rows = total rows - (1 prime row) - (1 special row)

	/* *****************************  Input Name and Show Choice ********************************************** */

	for {
		fmt.Print("Hello New Customer, ")

		if (comedyShow.getSalesNum() == numSeats && tragedyShow.getSalesNum() == numSeats) { 		// Displays a message if both shows have sold out
			fmt.Println("We are sorry to inform you that both of our shows have sold out.")
			fmt.Println("Please come back another time")
			break
		}

		reader := bufio.NewReader(os.Stdin)		
		fmt.Print("what is your name? \n")
		spectatorName, _ := reader.ReadString('\n')						// Read user input for spectatorName

		fmt.Println()
		fmt.Println("Welcome, " + spectatorName )						// Greet user

		var showChoice int = 0											// showChoice is used to indicate which show the user will pick

		fmt.Println("What kind of show would you like to watch?")
		fmt.Println("Input 0: Comedy")
		fmt.Println("Input 1: Tragedy")
		fmt.Println("Input 2: Exit Program ")
		fmt.Println("Input 3: Info on the shows")


		_, err := fmt.Scanf("%d \n", &showChoice) 						// Read user input for showChoice

		if (showChoice == 3) { 											// If user has shown "Show Info" option, display show details 
			comedyShow.displayShowInfo(numSeats)
			tragedyShow.displayShowInfo(numSeats)
		} 

		for err != nil || showChoice < 0 || showChoice > 2 {			// Loop until user has picked between 0 (comedy), 1 (tragedy) or 2 (leave)
			fmt.Println("Please select 0 (Comedy) or 1 (Tragedy) or 2 (Leave) as an input")
			_, err = fmt.Scanf("%d \n", &showChoice)
		}

		if (showChoice == 2) {											// User leaves
			fmt.Println("Have a good day!")
			break
		}
	
		var requestedShow Show = mainTheatre.shows[showChoice]			// Using the showChoice int as an index, retrieve the show that the user wants to wathc

		if (requestedShow.getSalesNum() == numSeats) { 					// Inform the user that this show has sold out IF there are no more seats left
			fmt.Println()
			fmt.Println("We are sorry to inform you that we have sold out all of our tickets for this show. Please select another option")
			continue
		}

		fmt.Println()
		fmt.Println("You chose the following play: " + requestedShow.getName()) 	// Confirm to the user that he chose a show

		/* ********************************** Input Category Choice  ********************************************** */

		categoryChoice := 0												// categoryChoice is used to indicate which category the user wants to be in
		var hasChosenCategory bool = false 								// Boolean indicating that he/she has chosen a category

		fmt.Println("Please pick a Category")
		fmt.Println("Input 0: Prime")
		fmt.Println("Input 1: Standard")
		fmt.Println("Input 2: Special")

		_, err = fmt.Scanf("%d \n", &categoryChoice)					// Read input for categoryChoice

		if (requestedShow.hasEmptySeats(categoryChoice, numSeats, numRows)) { 			// Check if there are remaining Seats in that Category
			hasChosenCategory = true
		}

		for (err != nil || categoryChoice < 0 || categoryChoice > 2 || hasChosenCategory == false) { // Loop until user has properly selected an available cateogry
			if (!hasChosenCategory) {
				fmt.Println("We are sorry but the requested Category no longer has available seats." )
			}

			hasChosenCategory = false
			fmt.Println("Please select 0 (Prime) or 1 (Standard) or 2 (Special) as an input")
			_, err = fmt.Scanf("%d \n", &categoryChoice)
			
			if (requestedShow.hasEmptySeats(categoryChoice, numSeats, numRows)) { 
				hasChosenCategory = true 											// Acceptable input, loop can break
			} 

		}

	
		fmt.Println()

		/* ************************************ Display Available Seats and Take Seat Input ********************************************** */

		var seatChoice int32 = 0												// seatChoice is used to indicate which seat the user will sit in
		var tempTicket Ticket; 

		if (categoryChoice == 0) {	 											// Display seats for PRIME Category

			fmt.Println("You chose the following Category: " + Prime + ". Here are its available seats:")
			fmt.Println("Please pick a seat number")
			requestedShow.showEmptySeats(categoryChoice, numSeats, numRows) // Display empty seats 
			fmt.Println()
			fmt.Print("Input a number from 0 to ")
			fmt.Print(seatsPerRow - 1) 
			fmt.Println()


			_, err = fmt.Scanf("%d \n", &seatChoice)					// Read user input for seatChoice

			for err != nil || seatChoice < 0 || seatChoice > seatsPerRow - 1 { 	// Loop until the input is valid
				fmt.Println()
				fmt.Print("Invalid Input: Select a seat number from 0 to ")
				fmt.Print(seatsPerRow - 1)
				fmt.Println()

				_, err = fmt.Scanf("%d \n", &seatChoice)
			}

			var acceptedTicketPurchase bool = false 					// Boolean to store wether the seat is already taken or not
			for (!acceptedTicketPurchase) {

				var requestedSeat Seat = mainTheatre.seats[seatChoice] 	// Use the seatChoice as an index to retrieve the requested seat instance

				tempTicket = NewTicket(spectatorName, &requestedSeat, &requestedShow) // Create a newTicket based off of the requestedSeat variable
		
				acceptedTicketPurchase = requestedShow.addPurchase(&tempTicket)		  // If addPurchase() returns true, then the seat is free to be purchased

				if (!acceptedTicketPurchase) { 										  // If not, loop until user has picked an available seat
					fmt.Println("We are sorry but that seat number has been taken.")
					fmt.Println("\nPlease select one of the seat numbers displayed above")

					_, err = fmt.Scanf("%d \n", &seatChoice)

					for err != nil || seatChoice < 0 || seatChoice > seatsPerRow - 1{
						fmt.Println("Invalid Input: Please select one of the seat numbers displayed above")
						_, err = fmt.Scanf("%d \n", &seatChoice)
					}

				}

			}
			
		} else if (categoryChoice == 1) { 							// Display seats for STANDARD Category


			/*

				The following Code follows the exact same format as the code seen for the (categoryChoice == 0) section.
				Therefore, there will be no comments here

			*/

			
			fmt.Println("You chose the following Category: " + Standard + ". Here are its available seats:")
			fmt.Println("Please pick a seat number")
			requestedShow.showEmptySeats(categoryChoice, numSeats, numRows)
			fmt.Println()
			fmt.Print("Input a number from ")
			fmt.Print(seatsPerRow) 
			fmt.Print(" to ")
			fmt.Print(((numStandardRows+1)*seatsPerRow) -1)
			fmt.Println()


			_, err = fmt.Scanf("%d \n", &seatChoice)

			for err != nil || seatChoice < seatsPerRow || seatChoice > (((numStandardRows+1)*seatsPerRow) -1) {
				fmt.Println()
				fmt.Print("Invalid Input: Select a seat number from ")
				fmt.Print(seatsPerRow) 
				fmt.Print(" to ")
				fmt.Print(((numStandardRows+1)*seatsPerRow) -1)
				fmt.Println()

				_, err = fmt.Scanf("%d \n", &seatChoice)
			}

			var acceptedTicketPurchase bool = false
			for (!acceptedTicketPurchase) {

				var requestedSeat Seat = mainTheatre.seats[seatChoice]
				tempTicket = NewTicket(spectatorName, &requestedSeat, &requestedShow)
		
				acceptedTicketPurchase = requestedShow.addPurchase(&tempTicket)

				if (!acceptedTicketPurchase) {
					fmt.Println("We are sorry but that seat number has been taken.")
					fmt.Println("\nPlease select one of the seat numbers displayed above")

					_, err = fmt.Scanf("%d \n", &seatChoice)

					for err != nil || seatChoice < seatsPerRow || seatChoice > (((numStandardRows+1)*seatsPerRow) -1) {
						fmt.Println("Invalid Input: Please select one of the seat numbers displayed above")
						_, err = fmt.Scanf("%d \n", &seatChoice)
					}

				}

			}


		} else {														// Display seats for SPECIAL Category

			/*

				The following Code follows the exact same format as the code seen for the (categoryChoice == 0) section.
				Therefore, there will be no comments here

			*/

			fmt.Println("You chose the following Category: " + Special + ". Here are its available seats:")
			fmt.Println("Please pick a seat number")
			requestedShow.showEmptySeats(categoryChoice, numSeats, numRows)
			fmt.Println()
			fmt.Print("Input a number from ")
			fmt.Print((numStandardRows+1)*seatsPerRow) 
			fmt.Print(" to ")
			fmt.Print(numSeats - 1)
			fmt.Println()


			_, err = fmt.Scanf("%d \n", &seatChoice)

			for err != nil || seatChoice < ((numRows - 1)*seatsPerRow) || seatChoice > numSeats - 1 {
				fmt.Println()
				fmt.Print("Invalid Input: Select a seat number from ")
				fmt.Print((numStandardRows+1)*seatsPerRow) 
				fmt.Print(" to ")
				fmt.Print(numSeats - 1)
				fmt.Println()

				_, err = fmt.Scanf("%d \n", &seatChoice)
			}

			var acceptedTicketPurchase bool = false
			for (!acceptedTicketPurchase) {

				var requestedSeat Seat = mainTheatre.seats[seatChoice]
				tempTicket = NewTicket(spectatorName, &requestedSeat, &requestedShow)
		
				acceptedTicketPurchase = requestedShow.addPurchase(&tempTicket)

				if (!acceptedTicketPurchase) {
					fmt.Println("We are sorry but that seat number has been taken.")
					fmt.Println("\nPlease select one of the seat numbers displayed above")

					_, err = fmt.Scanf("%d \n", &seatChoice)

					for err != nil || seatChoice < ((numRows - 1)*seatsPerRow) || seatChoice > numSeats - 1 {
						fmt.Println("Invalid Input: Please select one of the seat numbers displayed above")
						_, err = fmt.Scanf("%d \n", &seatChoice)
					}

				}

			}

		}

		/* ********************************* Display Purchased Ticket Info ************************************************* */

		fmt.Println("\nThank you for purchasing a ticket. Here is your Ticket Info: \n") 				// User has successfully purchased a seat
		tempTicket.displayTicketInfo(numSeats)															// Display all of the ticket info for the user

		/* ****************************************** End ***************************************** */

	}
}


/*
	The following METHOD establishes all of the Seat instances that will be found in the Theatre instance
*/
func (theatre Theatre) BuildTheatre(totalSeatNum int32, totalRowNum int32) {
	var rowIndex int32 = 1;

	var seatCounter int32 = 0;
	var seatIndex int32 = 0;

	var seatsPerRow int32 = totalSeatNum / totalRowNum


	var PrimeCategory Category = Category{35.0, Prime}					// Create Prime Category
	var StandardCategory Category = Category{25.0, Standard}			// Create Standard Category
	var SpecialCategory Category = Category{15.0, Special}				// Create Special Category

	for seatIndex < totalSeatNum {				// Iterate for all seats (totalSeatNum)
		if seatCounter == seatsPerRow {			// If seatCounter has reached the end of a row, go to the next row
			seatCounter = 0
			rowIndex++ 							// This is important because each row might be in a different Category than the previous row
		}

		if (rowIndex == 1) { 															// First row (prime category)
			theatre.seats[seatIndex] = NewSeat(seatIndex, rowIndex, &PrimeCategory)		// Create a new Seat instance at seatIndex as a Prime Category

		} else if (rowIndex == totalRowNum) { 											// Last row (special category)
			theatre.seats[seatIndex] = NewSeat(seatIndex, rowIndex, &SpecialCategory)	// Create a new Seat instance at seatIndex as a Special Category

		} else { 																		// Remaining rows (standard category)
			theatre.seats[seatIndex] = NewSeat(seatIndex, rowIndex, &StandardCategory)	// Create a new Seat instance at seatIndex as a Standard Category
		}
		
		seatIndex++ 
		seatCounter++
	}

}


// Creates a new Comedy with non-default values
func NewComedy(laughs float32, deaths int32, playName string, startTime time.Time, endTime time.Time) Comedy {
	var ticketSales int32 = 0
	var ticketSalesPTR *int32 = &ticketSales  
	tempPlay := Play{playName, make([]Ticket, 100), ticketSalesPTR, startTime, endTime}
	return Comedy{laughs, deaths, tempPlay}
}


// Creates a new Tragedy with non-default values
func NewTragedy(laughs float32, deaths int32, playName string, startTime time.Time, endTime time.Time) Tragedy {
	var ticketSales int32 = 0
	var ticketSalesPTR *int32 = &ticketSales
	tempPlay := Play{playName, make([]Ticket, 100), ticketSalesPTR, startTime, endTime}
	return Tragedy{laughs, deaths, tempPlay}
}


// Creates a new Seat with non-default values
func NewSeat(seatNum int32, seatRow int32, cat *Category) Seat {
	return Seat{seatNum, seatRow, cat}
}

// Creates a new Ticket with non-default values
func NewTicket(spectatorName string, seat *Seat, show *Show) Ticket {
	return Ticket{spectatorName, seat, show}
}

// Creates a new Theatre, checks if all parameters are valid
func NewTheatre(totalSeatNum int32, totalRowNum int32, showSlice []Show) Theatre {
	if (totalSeatNum % totalRowNum != 0) {
		panic("ERROR: Unable to have equal number of seats per row due to invalid user input")
	} 

	if (totalRowNum < 3) {
		panic("ERROR: Theatre must have AT LEAST 3 Rows")
	}

	if (totalSeatNum > 100) {
		panic("ERROR: Theatre cannot exceed seat limit of 100 (See NewTragedy() and NewComedy() Ticket slice size)")
	}

	return Theatre{make([]Seat, totalSeatNum), showSlice}
}


func (c Comedy) getName() string {
	return c.play.name
}

func (c Comedy) getShowStart() time.Time {
	return c.play.showStart
}

func (c Comedy) getShowEnd() time.Time {
	return c.play.showEnd
}


// Adds newTicket to the list of purchased tickets list
func (c Comedy) addPurchase(newTicket *Ticket) bool {

	if (c.isNotPurchased(newTicket)) { 								// Checks if this ticket info has not already been reserved (purchased)
		c.play.purchased[newTicket.siege.number] = *newTicket 		// If not, add to the list
		
		*c.play.ticketSales++										// Increment comedy ticket sales

		return true 												// Return true for successful purchase
	} 

	return false 													// Ticket has already been purchased, return false

}

// Checks if this ticket has already been purchased
// This METHOD uses the siege.number (seatNumber) variable as an index to reference the Ticket that is associated with the specific seat number
func (c Comedy) isNotPurchased(newTicket *Ticket) bool { 			
	if (c.play.purchased[newTicket.siege.number] != Ticket{}) { // If the ticket is NOT an empty instance, then it means that someone has already purchased for that seat number
		return false 	 										// Return false											
	}

	return true 												// Test passed, return true
}


/* ************************ The same comments go for the following Tragedy methods ********************** */

func (t Tragedy) getName() string {
	return t.play.name
}

func (t Tragedy) getShowStart() time.Time {
	return t.play.showStart
}

func (t Tragedy) getShowEnd() time.Time {
	return t.play.showEnd
}

func (t Tragedy) addPurchase(newTicket *Ticket) bool {
	if (t.isNotPurchased(newTicket)) {
		t.play.purchased[newTicket.siege.number] = *newTicket

		*t.play.ticketSales++
		
		return true
	} 

	return false
}

func (t Tragedy) isNotPurchased(newTicket *Ticket) bool {
	if (t.play.purchased[newTicket.siege.number] != Ticket{}) {
		return false
	}

	return true
}


// Return the amount of tickets sold for the Comedy show
func (c Comedy) getSalesNum() int32 {
	var sales int32 = *c.play.ticketSales
	return sales
}

// Return the amount of tickets sold for the Tragedy show
func (t Tragedy) getSalesNum() int32 {
	var sales int32 = *t.play.ticketSales
	return sales
}

// Display all of the show information for the Comedy Show (Called when user first picks input #3)
func (c Comedy) displayShowInfo(totalSeatNum int32) {
	fmt.Println("		COMEDY LINEUP		") 
	fmt.Println("Play Name: " + c.getName())
	fmt.Print("Start Time:	")
	fmt.Print(c.getShowStart())
	fmt.Println()
	fmt.Print("End Time:	")
	fmt.Print(c.getShowEnd())
	fmt.Println()
	fmt.Print("Tickets Sold (Out of ")
	fmt.Print(totalSeatNum)
	fmt.Print("): ")
	fmt.Print(c.getSalesNum())
	fmt.Println()
	fmt.Println()
}
// Display all of the show information for the Tragedy Show (Called when user first picks input #3)
func (t Tragedy) displayShowInfo(totalSeatNum int32) {
	fmt.Println("		TRAGEDY LINEUP		") 
	fmt.Println("Play Name: " + t.getName())
	fmt.Print("Start Time:	")
	fmt.Print(t.getShowStart())
	fmt.Println()
	fmt.Print("End Time:	")
	fmt.Print(t.getShowEnd())
	fmt.Println()
	fmt.Print("Tickets Sold (Out of ")
	fmt.Print(totalSeatNum)
	fmt.Print("): ")
	fmt.Print(t.getSalesNum())
	fmt.Println()
	fmt.Println()
}

/*
	showEmptySeats()

	This METHOD loops through each row associated to a specific category and displays all Seat instances that are empty (Ticket{})
	This is done by using the "purchased" list

	When a Ticket instance is empty (like this: Ticket{}), then it means that the seat associated to that Ticket has not been reserved.
	Therefore, with this information, we can display that seat as an available choice for the user

*/
func (c Comedy) showEmptySeats(catChoice int, totalSeatNum int32, totalRowNum int32) {
	var seatsPerRow int32 = totalSeatNum / totalRowNum
	var numStandardRows int32 = totalRowNum - 2
	var numStandardSeats int32 = numStandardRows * seatsPerRow

	// The variable x will be used as an index to reference each Ticket in the purchased list (it also acts as the seatNumber at the same time)	
	var x int32 									
	if (catChoice == 0) {							// Prime Category

		for x = 0; x < seatsPerRow; x++ { 			// Loop through the first row (since we know that Prime is only ever the FIRST row in a Theatre)
			if (c.play.purchased[x] == Ticket{}) {  // If the current Ticket is an empty instance
				fmt.Print("#")
				fmt.Print(x) 
				fmt.Print(" is currently free \n") 	// Display it as an empty seat
			}
		}

	} else if (catChoice == 1) {					// Standard Category

		for x = seatsPerRow; x < (numStandardSeats + seatsPerRow); x++ { // Loop through all Standard seats (Which is always from the SECOND Row to the BEFORE last Row)
			if (c.play.purchased[x] == Ticket{}) {
				fmt.Print("#")
				fmt.Print(x) 
				fmt.Print(" is currently free \n")
			}
		}

	} else {										// Special Category
		for x = (numStandardSeats + seatsPerRow); x < totalSeatNum; x++ { // Loop through the Special seats (Which is always the LAST row)
			if (c.play.purchased[x] == Ticket{}) {
				fmt.Print("#")
				fmt.Print(x) 
				fmt.Print(" is currently free \n")
			}
		}

	}

}

/*
	The code here is of the exact same style as for the showEmptySeats() method for the comedy show.
	There will be no comments here.

*/
func (t Tragedy) showEmptySeats(catChoice int, totalSeatNum int32, totalRowNum int32) {
	var seatsPerRow int32 = totalSeatNum / totalRowNum
	var numStandardRows int32 = totalRowNum - 2
	var numStandardSeats int32 = numStandardRows * seatsPerRow

	var x int32
	if (catChoice == 0) {		// Prime 
		for x = 0; x < seatsPerRow; x++ {
			if (t.play.purchased[x] == Ticket{}) {
				fmt.Print("#")
				fmt.Print(x) 
				fmt.Print(" is currently free \n")
			}
		}

	} else if (catChoice == 1) {// Standard
		for x = seatsPerRow; x < (numStandardSeats + seatsPerRow); x++ {
			if (t.play.purchased[x] == Ticket{}) {
				fmt.Print("#")
				fmt.Print(x) 
				fmt.Print(" is currently free \n")
			}
		}

	} else {					// Special
		for x = (numStandardSeats + seatsPerRow); x < totalSeatNum; x++ {
			if (t.play.purchased[x] == Ticket{}) {
				fmt.Print("#")
				fmt.Print(x) 
				fmt.Print(" is currently free \n")
			}
		}

	}
}


/*
	The hasEmptySeats method follows the exact same format as the showEmptySeats() method.

	However, instead of displaying available seats, it simply returns true if it has found
	AT LEAST 1 empty Ticket instance.

	This implies that there is an empty seat for a specific category.


*/
func (c Comedy) hasEmptySeats(catChoice int, totalSeatNum int32, totalRowNum int32) bool {
	var seatsPerRow int32 = totalSeatNum / totalRowNum
	var numStandardRows int32 = totalRowNum - 2
	var numStandardSeats int32 = numStandardRows * seatsPerRow

	var x int32
	if (catChoice == 0) {						// Prime 
		for x = 0; x < seatsPerRow; x++ {
			if (c.play.purchased[x] == Ticket{}) { 
				return true 						// We have found an empty seat for the Prime Category, thus return true
			}
		}

	} else if (catChoice == 1) {				// Standard
		for x = seatsPerRow; x < (numStandardSeats + seatsPerRow); x++ {
			if (c.play.purchased[x] == Ticket{}) {
				return true 						// We have found an empty seat for the Standard Category, thus return true
			}
		}

	} else {									// Special
		for x = (numStandardSeats + seatsPerRow); x < totalSeatNum; x++ {
			if (c.play.purchased[x] == Ticket{}) {
				return true 						// We have found an empty seat for the Special Category, thus return true
			}
		}

	}

	return false
}


/*
	The code here is of the exact same style as for the hasEmptySeats() method for the comedy show.
	There will be no comments here.

*/
func (t Tragedy) hasEmptySeats(catChoice int, totalSeatNum int32, totalRowNum int32) bool {

	var seatsPerRow int32 = totalSeatNum / totalRowNum
	var numStandardRows int32 = totalRowNum - 2
	var numStandardSeats int32 = numStandardRows * seatsPerRow

	var x int32
	if (catChoice == 0) {		// Prime 
		for x = 0; x < seatsPerRow; x++ {
			if (t.play.purchased[x] == Ticket{}) {
				return true
			}
		}

	} else if (catChoice == 1) {// Standard
		for x = seatsPerRow; x < (numStandardSeats + seatsPerRow); x++ {
			if (t.play.purchased[x] == Ticket{}) {
				return true
			}
		}

	} else {					// Special
		for x = (numStandardSeats + seatsPerRow); x < totalSeatNum; x++ {
			if (t.play.purchased[x] == Ticket{}) {
				return true
			}
		}

	}

	return false
}

// Display all the information associated to a Ticket (called when user has successfully purchased a Ticket for a show)
func (ticket Ticket) displayTicketInfo(totalSeatNum int32) {
	var seat Seat = *ticket.siege
	var show Show = *ticket.s

	fmt.Println("Ticket Owner Name: " + ticket.customer)

	fmt.Print("Ticket Price: ")
	fmt.Print(seat.cat.base)
	fmt.Print("$")
	fmt.Println()
	fmt.Print("Play Info: ")
	show.displayShowInfo(totalSeatNum)
	fmt.Println()
	fmt.Print("Seat Number: ")
	fmt.Print(seat.number)
	fmt.Println()
	fmt.Print("Seat Row: ")
	fmt.Print(seat.row)
	fmt.Println()
	fmt.Print("Category: ")
	fmt.Print(seat.cat.name)
	fmt.Println()
	fmt.Println()
}