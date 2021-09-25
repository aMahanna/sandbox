print("Demo example: 'binarySearch([1, 2, 3, 4, 4, 5, 7, 9, 10, 13], 10)'")
print("Returns True if the value is located inside the list using binary search")

def binarySearch(myList, value) :
    steps = 0
    start = 0 # first index
    end = len(myList) - 1 # last index

    if len(myList) == 0: # Empty list
    	return False
    	
    while start <= end:
        steps +=1
        mid = (end + start)//2
        if myList[mid] == value:
            print("Number of steps: " + str(steps))
            return True # Found!
        else:
            
            if value < myList[mid]: # Look on the left
                end = mid - 1
            else: # Look on the right
                start = mid + 1

    print("Number of steps: " + str(steps))
    return False 

        


            
    
    

