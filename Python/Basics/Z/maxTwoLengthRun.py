# Asks user to input a series a numbers 
numbers = input("Please input a list of numbers separated by a space: ")
# Converts the values to a list 
myList = numbers.split(' ')

def twoLengthRun(myList):
    """ Returns the count of the biggest twoLengthRun in the list """

    # Define counter variables
    count = 1
    maxcount = 1
    for i in range(1, len(myList)): # Loops through the list 
        
        if (myList[i-1] == myList[i]): # Verifies if there is a twoLengthRun
            count += 1 

        elif (count > maxcount): # If count surpasses the previous max, replace
            maxcount = count
           
        else: # Resets count variable to 1
            count = 1
            
    return maxcount

# Prints result
print(twoLengthRun(myList)) 

        
