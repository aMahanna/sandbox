# Asks user to input a series a numbers 
numbers = input("Please input a list of numbers separated by a space: ")
# Converts the values to a list 
myList = numbers.split(' ')

# Function counting positive numbers in a list
def countPos(myList):
    ''' Counts the number of positives values in a list '''
    counter = 0
    # Loop to pass through all elements in myList
    for element in myList:
        # If the condition is validated, increase counter 
        if (int(element) > 0):
            counter += 1
    
    return counter

# Calls the function and displays to user 
callFunction = countPos(myList)
print("There are", callFunction, "positive numbers in your list.")
            


