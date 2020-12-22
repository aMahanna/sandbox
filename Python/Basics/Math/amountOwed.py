# User inputs amount owed 
amountOwed = float(input("Enter the amount you are owed in $: "))

def returnCoins(amountOwed):
    "Function that computes the amount of coins returned based on amount owed"
    # Variable tracking coins returned 
    coinNumber = 0
    
    # Loop breaks when amountOwed is below 0. 
    while (amountOwed >= 0):

        # Verifies if each coin value can be substracted from amountOwed 
        if (amountOwed - 0.25 >= 0):
           amountOwed -= 1/4
           coinNumber += 1 # Adds a unit to the expected amount of coins returned 
           
        elif (amountOwed - 0.10 >= 0):
            amountOwed -= 1/10
            coinNumber += 1
            
        elif (amountOwed - 0.05 >= 0):
            amountOwed -= 1/20
            coinNumber += 1
            
        elif (amountOwed - 0.01 >= 0):
            amountOwed = round((amountOwed - 1/100), 3)
            coinNumber += 1

        # If amountOwed can't fit any more coins, the loop ends 
        else:
            break

    # Displays the output for the user 
    print("The minimum number of coins the cashier can return is: ", coinNumber)
            

# Calls the function 
computeCoins = returnCoins(amountOwed)

