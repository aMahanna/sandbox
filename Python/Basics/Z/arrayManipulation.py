import copy

def inputArray():
    ''' Function that converts user's input of numbers into an array. Returns
    the array. '''
    
    myArray = []
    print("Input the array elements with spaces between columns.")
    print("One row per line, and an empty line at the end.")

    while True:
        row = input()

        if not row: 
            break

        numberInput = row.split() # Turns input into a list of numbers (strings)
        
        # Converts inputted numbers into integers through a loop
        row = [int(numberInput) for numberInput in numberInput] 
        myArray.append(row) # Appends the created array 

    return myArray
    

def add(myArray):
    ''' Adds 1 to all elements of an Array. Returns the array '''

    # Adds 1 to every single element inside the array
    for row in range(len(myArray)): # Loops through rows
        for col in range(len(myArray[row])): # Loops through columns 
            myArray[row][col] += 1
    
    return myArray


def add_V2(myArray):
    ''' Increments 1 to a copied version of the initially modified array.
    Returns the copied array '''

    # Initializes new array
    copyArray = []
    
    for i in range(len(myArray)): # Loops through the correct dimensions of the original array
        copyArray.append([]) # Inserts the proper number of sub-lists 

        for j in range(len(myArray[i])): # Loops through the dimension of each sub-list
            print(len(myArray[i]))
            copyArray[i].append(myArray[i][j]+1) # Appends by the original element of myArray and adds 1 
    

    # For more practical use, we can use the deepcopy method to copy the original array and call the first add function:
    # copyArray = copy.deepcopy(myArray)
    # add(copyArray)
    # Saves time and space
    
    return copyArray

def main():

    # Creates the initial array
    initialArray = inputArray()
    print("The array is:\n" + str(initialArray))

    # Adds 1 to all elements of the initial array to create the modified array
    modifiedArray = add(initialArray)
    print("\nAfter executing the function add, the array is:\n" + str(modifiedArray))

    # Increments a copy of the modified array by 1
    incrementedArray = add_V2(modifiedArray)
    print("\nA new array is created with add_V2 (increments by 1):\n" + str(incrementedArray))

    # Displays the initially modified array to show that is has not been changed (thanks to deepcopy)
    print("\nAfter executing the function 'add_V2', the initial array is:\n" + str(modifiedArray))

    
main()
