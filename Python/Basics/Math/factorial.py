# Asks user to input an int 
number = int(input("Insert a number: "))

# Function computing factorial 
def computeFact(number):

    
    # Loop that verifies that number is positive
    while (number != "number"):

        if (number < 0):
            print("Please insert a number bigger than 0")
            number = int(input("Insert: "))

        else:
            break
    
    factorial = 1

    # Calculates factorial with a loop 
    while number >= 1:
        factorial *=  number
        number -= 1

    return factorial

# Calls function and prints result
call = computeFact(number)
print(call)

    

