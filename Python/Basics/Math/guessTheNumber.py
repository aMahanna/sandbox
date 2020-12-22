import random

# Function to guess a random integer created by the computer 
def guess():

    randomNumber = int(10*random.random() + 1)
    guessedNumber = int(input("Can you guess the number?: "))
    tries = 0
    
    # Loop that provides hints to the user depending on the value of the guess
    while (randomNumber != "guess"):
        
        if (guessedNumber < randomNumber):
            print ("Your guess is too low!")
            guessedNumber = int(input("Guess again: "))
            tries += 1
            
        elif (guessedNumber > randomNumber):
            print ("You guess is too high!")
            guessedNumber = int(input("Guess again: "))
            tries +=1
            
        else:
            print ("Well done! It only took you", tries, "tries")
            break

# Calls function 
callFunction = guess()
