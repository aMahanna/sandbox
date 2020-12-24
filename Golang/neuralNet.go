package main

import (
	"fmt"
	"math"
)

func sigmoid(v float64) float64 { // Sigmoid function
	return 1.0 / (1.0 + math.Exp(-v))
}

func computeX1(k float64, sizeN float64) float64 { // Computes X1 using k {0, 1, 2, ... , N - 1} and user input sizeN
	return math.Sin((2 * math.Pi * k) / sizeN)
}

func computeX2(k float64, sizeN float64) float64 { // Computes X2 using k {0, 1, 2, ... , N - 1} and user input sizeN

	return math.Cos((2 * math.Pi * k) / sizeN)
}

func computeZ1(xOne float64, xTwo float64) float64 { // Computes Z1 using weights (a10, a11, a12) and sigmoid function
	// var a10 float64 = 0.1
	// var a11 float64 = 0.3
	// var a12 float64 = 0.4

	var v1 float64 = 0.1 + (0.3 * xOne) + (0.4 * xTwo)
	return sigmoid(v1)

}

func computeZ2(xOne float64, xTwo float64) float64 { // Computes Z2 using weights (a10, a11, a12) and sigmoid function
	// var a20 float64 = 0.5
	// var a21 float64 = 0.8
	// var a22 float64 = 0.3

	var v2 float64 = 0.5 + (0.8 * xOne) + (0.3 * xTwo)
	return sigmoid(v2)
}

func computeZ3(xOne float64, xTwo float64) float64 { // Computes Z1 using weights (a30, a31, a32) and sigmoid function
	// var a30 float64 = 0.7
	// var a31 float64 = 0.6
	// var a32 float64 =0.6

	var v3 float64 = 0.7 + (0.6 * xOne) + (0.6 * xTwo)
	return sigmoid(v3)
}

func computeT1(z1 float64, z2 float64, z3 float64) float64 { // Computes T1 using weights (b10, b11, b12, b13) and sigmoid function
	// var b10 float64 = 0.5
	// var b11 float64 = 0.3
	// var b12 float64 = 0.7
	// var b13 float64 = 0.1

	var v float64 = 0.5 + (0.3 * z1) + (0.7 * z2) + (0.1 * z3)
	return sigmoid(v)
}

func main() {
	var sizeN int32 = 1
	fmt.Print("Input number of iterations N (1 or higher): ")

	_, err := fmt.Scanf("%d \n", &sizeN) // Ask user for input

	for err != nil || sizeN < 1 { // Check that it is a positive integer only
		fmt.Println("Must be positive integer (1 or higher).")
		fmt.Println("Number of iterations N: ")
		_, err = fmt.Scanf("%d \n", &sizeN)
	}

	var i int32
	var k float64

	var done chan bool

	fmt.Println("    T")

	for i = 0; i < sizeN; i++ { // Iterate N times based on user input
		k = float64(i) // Create K as a float64 from the index

		done = make(chan bool)

		x1Chan := make(chan float64, 1) // x1Chan stores the value received from computeX1

		go func() { // Goroutine Lambda function
			x1Chan <- computeX1(k, float64(sizeN)) // Compute x1 and store in channel

			for {
				select {
				case <-done: // Loop until a done signal has been received
					close(x1Chan) // Close channel
					return        // Exit go routine
				}
			}

		}()

		x2Chan := make(chan float64, 1) // x2Chan stores the value received from computeX2

		go func() { // Goroutine lambda function
			x2Chan <- computeX2(k, float64(sizeN)) // Compute z2 and store in channel

			for {
				select {
				case <-done: // Loop until a done signal has been received
					close(x2Chan) // Close channel
					return        // Exit goroutine
				}
			}

		}()

		xOne := <-x1Chan // Retrieve x1 channel value
		xTwo := <-x2Chan // Retrieve x2 channel value

		done <- true // Send done signal
		done <- true

		/*
			The process above (line 83 - 121) is repeated 2 more times to compute Z1, Z2, Z3 and T1
		*/

		z1Chan := make(chan float64, 1)
		go func() {
			z1Chan <- computeZ1(xOne, xTwo)

			for {
				select {
				case <-done:
					close(z1Chan)
					return
				}

			}
		}()

		z2Chan := make(chan float64, 1)
		go func() {
			z2Chan <- computeZ2(xOne, xTwo)
			for {
				select {

				case <-done:
					close(z2Chan)
					return
				}

			}
		}()

		z3Chan := make(chan float64, 1)
		go func() {
			z3Chan <- computeZ3(xOne, xTwo)
			for {
				select {

				case <-done:
					close(z3Chan)
					return
				}

			}
		}()

		zOne := <-z1Chan
		zTwo := <-z2Chan
		zThree := <-z3Chan

		done <- true
		done <- true
		done <- true

		t1Chan := make(chan float64, 1)
		go func() {
			t1Chan <- computeT1(zOne, zTwo, zThree)

			for {
				select {
				case <-done:
					close(t1Chan)
					return

				}

			}

		}()

		tOne := <-t1Chan

		done <- true

		/*

			Display info in the following format:

			K = ____
			X1, X2 = (____, _____)
			T = _______

		*/

		fmt.Println()
		fmt.Print("K = ")
		fmt.Print(i)
		fmt.Println()
		fmt.Print("X1, X2 = (")
		fmt.Print(xOne)
		fmt.Print(", ")
		fmt.Print(xTwo)
		fmt.Print(")")
		fmt.Println()
		fmt.Print("T = ")
		fmt.Print(math.Round(tOne*1000000) / 1000000) // T is rounded to 6 decimal paces
		fmt.Println()

	}

}
