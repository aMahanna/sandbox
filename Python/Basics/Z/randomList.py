import random

print("Creates a random list. EXAMPLE: 'count(aList, x)' for x a number in aList")
print("Counts the number of occurences of 'value' inside the generated list")

def randomList():
    l1 = []
    N = 100
    for index in range(N):
        randomNum = random.randrange(1,N+1)
        l1.append(randomNum)
    
    return l1

def count(aList, value):
    count = 0
    steps = 0
    
    for i in range(len(aList)):
        steps += 1
        
        if aList[i] == value:
            count += 1
            
        
    print("Number of steps: " + str(steps))
    return count


aList = randomList()
print("aList = " + str(aList))
