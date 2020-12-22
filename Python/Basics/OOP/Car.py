class Car():

    # Constructor element. Takes account of brand, color, driver name and initial speed
    def __init__(self, brand = 'Ford', color = 'Red', pilote = 'Person', speed = 0):

        self.brand = brand
        self.color = color
        self.driver = pilote
        self.speed = speed

    # Display all properties of Car class
    def displayAll(self):

        return str(self.color) + ' ' + str(self.brand) + ' driven by ' + str(self.driver) + ', speed = ' + str(self.speed) + ' m/s.'

    # Allows user to change the driver name
    def choiceDriver(self, name):
        self.driver = name

    # Change the speed of the car
    def accelerate(self, flow, duration):
        if self.driver != 'Person':

            self.speed = float(flow) * float(duration)

        # Does not change speed if the driver name has not been changed. 
        else:

            return "This car does not have a driver!"

    

