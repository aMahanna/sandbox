package main
import (
	"fmt"
)

const max = 10

func parallelMergesort1(s []int, r chan []int) {

    if len(s) == 1 {
        r <- s
        return
    }

    mid := len(s)/2

    rightChan, leftChan := make(chan []int), make(chan []int)

    go parallelMergesort1(s[:mid], leftChan)
    go parallelMergesort1(s[mid:], rightChan)

    rightSide := <-rightChan
    leftSide := <-leftChan

    close(rightChan)
    close(leftChan)

    r <- channelMerge(rightSide, leftSide)
    return
}

func channelMerge(l []int, r []int) (res []int) {  

	res = make([]int, len(l)+len(r))

	leftIndex, rightIndex := 0, 0

	for i := 0; i < cap(res); i++ {

		switch {
			case leftIndex >= len(l):
				res[i] = r[rightIndex]
				rightIndex++

			case rightIndex >= len(r):
				res[i] = l[leftIndex]
				leftIndex++

			case l[leftIndex] < r[rightIndex]:
				res[i] = l[leftIndex]
				leftIndex++

			default:
				res[i] = r[rightIndex]
				rightIndex++
		}
	}
	return
}

func main() {
    mixedArray := []int{6,4,9,1,5,3,0,10,2,8,7}

    result := make(chan []int)


    go parallelMergesort1(mixedArray, result)
    r := <- result

    for _,num := range r {
        fmt.Println(num)
    }
    close(result)
}

// Old code

func merge(s []int, middle int) {
	helper := make([]int, len(s))
	copy(helper, s)

	helperLeft := 0
	helperRight := middle
	current := 0
	high := len(s) - 1

	for helperLeft <= middle-1 && helperRight <= high {
		if helper[helperLeft] <= helper[helperRight] {
			s[current] = helper[helperLeft]
			helperLeft++
		} else {
			s[current] = helper[helperRight]
			helperRight++
		}
		current++
	}

	for helperLeft <= middle-1 {
		s[current] = helper[helperLeft]
		current++
		helperLeft++
	}
}

/* Sequential */

func mergesort(s []int) {
	if len(s) > 1 {
		middle := len(s) / 2
		mergesort(s[:middle])
		mergesort(s[middle:])
		merge(s, middle)
	}
}

