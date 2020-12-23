# Define function to test a student (RANDOM OPERATIONS)
def testStudent():
    "Function that generates 10 random questions on multiplication and addition"
    import random
    # Variable to keep track of user's grade
    points = 0

    # Loop to generate 10 questions
    for index in range(0, 10):


        # Generates an integer of either 0 or 1 
        requestedOperation = random.randint(0,1)

        # If integer generated is 1, create a multiplication question
        if (requestedOperation == 1):
            numberOne = int(9*random.random() +1)
            numberTwo = int(9*random.random() +1)
            realAnswer = numberOne * numberTwo
            question = ("What is " + str(numberOne) + " x " + str(numberTwo) + "?: ")
            userInput = int(input(question))

            # If user answers correctly, add a point 
            if (userInput == realAnswer):
                points += 1
            # Otherwise, display the correct answer 
            else:
                print("Incorrect. The correct answer is " + str(realAnswer))

        # # If the integer generated is 0, create an addition question
        if (requestedOperation == 0):
            numberOne = int(9*random.random() +1)
            numberTwo = int(9*random.random() +1)
            realAnswer = numberOne + numberTwo
            question = ("What is " + str(numberOne) + " + " + str(numberTwo) + "?: ")
            userInput = int(input(question))
            
            # Verifies answer once again 
            if (userInput == realAnswer):
                points += 1
            else:
                print("Incorrect. The correct answer is " + str(realAnswer))

    # If user's grade is above 6/10, display that he passed along with his grade
    if (points >= 6):
        print("Congratulations! Grade: " + str(points) + "/10")
    
    # Otherwise, instructs user to see a teacher 
    else:
        print("Please ask your teacher for help. Grade: " + str(points) + "/10")

# Call the function once 
callFunction = testStudent()
