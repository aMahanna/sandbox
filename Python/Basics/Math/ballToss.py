import math
speed = int(input("Insert the speed in m/s of which the ball is thrown at: "))

def ballToss(speed):

    gravity = 9.8
    anglesDeg= [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]
    anglesRad = []
    distanceList = []
    
    for value in anglesDeg:
        rad = (math.pi/180) * value
        anglesRad.append(rad)

    for radians in anglesRad:
        distance = round(((2*(speed**2)*math.cos(radians)*math.sin(radians))/gravity), 2)
        distanceList.append(distance)

    print("The distances travelled by the ball if thrown at different angles are:")
    for index in range(0, 10):
        print(str(anglesDeg[index]), " degrees: " + str(distanceList[index]), " meters.")

        
callFunction = ballToss(speed)

    
