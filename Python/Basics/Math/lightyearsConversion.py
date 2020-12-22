# User inputs the value of lightyears to convert 
lightyears = float(input("Input a number of light-years: "))

# Define converYears function 
def convertYears(lightyears):
    "Function that converts lightyears to lightseconds"
    lightseconds = round(lightyears * 365.26 * 86400, 2)
    return lightseconds

# Calls the function and displays the result
transformedYears = convertYears(lightyears)
print("The number of seconds is ", transformedYears)


# Define convertSeconds function 
def convertSeconds(transformedYears):
    "Function that converts lightseconds to distance in km" 
    lightdistance =  round(transformedYears * 300000, 2)
    return lightdistance

# Calls the second function and displays the result
transformedSeconds = convertSeconds(transformedYears)
print("The distance is ", transformedSeconds, "km.")


# User inputs the distance of the first and second star from Earth
firstStar =  float(input("Input the distance (in light years) to the first star: "))
secondStar =  float(input("Input the distance (in light years) to the second star: "))

# Define computeDistance function
def computeDistance():
    "Finds the lightyear distance between two stars to find their distance in km"
    deltaYears = secondStar - firstStar

    # Calls the previous functions to calculate the total distance
    totalSeconds = convertYears(deltaYears)
    totalDistance = convertSeconds(totalSeconds)
    return totalDistance

# Calls the function and displays the result for the user 
finalDistance = computeDistance()
print("The distance between the two stars is ", finalDistance, "km.")
