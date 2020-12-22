values = input("Enter values for a list (seperate values with a comma): ")

myList = list(eval(values))

def calculateAverage(myList):
    sum = 0 
    for element in myList:
        sum += element

    average = round((sum / len(myList)), 2)
    print("The average of your list is", average)



call = calculateAverage(myList)
