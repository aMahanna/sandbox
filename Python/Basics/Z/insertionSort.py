print("Sorts the list by the insertion method. Example: insertionSort( [3, 4, -1, 7, 2, 5, 16, -2, 17, 7, 82, -1])")


def insertionSort(myList):
    
    for index in range(len(myList)):
        insertion(myList, index)

    return myList

def insertion(myList, position):
    steps = 0
    index = position
    tempValue = myList[position]
    
    while index != 0 and myList[index-1] > tempValue:
        index -=1
        
    del myList[position]
    myList.insert(index, tempValue)

