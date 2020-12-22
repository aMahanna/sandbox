# Asks the user to input the weight values
poundsInput = float(input("Enter the number of pounds in your weight: "))
ouncesInput = float(input("Enter the number of ounces in your weight: "))

# Defining the transformative equation
def weight_in_kilo():
    "Function that transforms pounds/ounces to kilograms"
    totalWeight = poundsInput + (ouncesInput /16)
    weightKilo = round(totalWeight / 2.2, 2)
    return weightKilo

# Calling the fucntion 
transformWeight = weight_in_kilo()

# Displays the output of the function for the user
print(poundsInput, " pound(s) and ", ouncesInput, " ounce(s) is around ",
      transformWeight, " kilogram(s).")
