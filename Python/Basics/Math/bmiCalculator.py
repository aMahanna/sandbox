# Define the BMI function  
def computeBMI():
    "Evaluates your BMI using your weight and height"
    # Asks user to input his weight and height 
    weight = float(input("Input your weight in kilograms: "))
    height = float(input("Input your height in meters: "))

    # Calculates user's BMI
    bmi = round(weight/(height**2), 1)

    # Conditions to assess the user's state of weight  
    if (bmi < 18.5):
        print("Based on your BMI, you are currently underweight: ")

    elif (bmi >= 18.5 and bmi < 25):
        print("Based on your BMI, you are currently at a normal weight: ")

    elif (bmi >= 25 and bmi < 30):
        print("Based on your BMI, you are currently overweight: ")

    else:
        print("Based on your BMI, you are currently obese: ")

    # Prints the calculated BMI 
    print(bmi)


# Calls the function and informs the user how to use it again 
callFunction = computeBMI()
print("To calculate your Body Max Index again, please type 'computeBMI()' on line below")
