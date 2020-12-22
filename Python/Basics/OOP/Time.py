class Time():

    # Time Constructor, checks if the inputs are within the conditions 
    def setTime(self, hh=12, mm=0, s=0):
        ''' (Time) -> None '''

        if (hh <= 0 or hh >= 23):
            hh = 12

        if (mm <= 0 or mm >= 59):
            mm = 0

        if (s <= 0 or s >= 59):
            s = 0 

        
        self.hour = hh
        self.minute = mm
        self.second = s

    # Displays the time object 
    def display(self):
        return (str(self.hour) + ":" + str(self.minute) + ":" + str(self.second))

    # Checks if two times share the same value
    def equivalent(self, other):

        return self.hour == other.hour and self.minute == other.minute and self.second == other.second

    # Verifies if time 'self' is before time 'other'
    def isBefore(self, other):

        if (int((str(self.hour) + str(self.minute) + str(self.second))) <
            (int(str(other.hour) + str(other.minute) + str(other.second)))):

            return True

        else:

            return False


    # Calculates the difference of time between object A and B
    def duration(self, other):

        deltaTime = Time()

        deltaTime.hour = abs(int(self.hour) - int(other.hour))
        deltaTime.minute = abs(int(self.minute) - int(other.minute))
        deltaTime.second = abs(int(self.second) - int(other.second))

        return (str(deltaTime.hour) + ":" + str(deltaTime.minute) + ":" + str(deltaTime.second))
