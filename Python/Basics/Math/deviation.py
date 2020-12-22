import math

numbers = input("Insert your list of numbers: ")

myList = list(eval(numbers))

def deviation(myList):

    numeratorDeviation = 0
    sum = 0

    for element in myList:
        sum += element

    average = sum / len(myList)

    for index in range(0, len(myList)):

        numeratorDeviation += (myList[index] - average)**2

    standardDeviation = round((math.sqrt(numeratorDeviation / (len(myList) - 1))), 2)


    print("The standard deviation of the values inserted is ", standardDeviation)


call = deviation(myList)
