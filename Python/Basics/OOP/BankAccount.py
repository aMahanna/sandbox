class BankAccount():

    # Constructor to build name and solde value
    def __init__(self, name = 'Dupont', solde = 1000, rate = 0.3):

        self.name = name
        self.solde = solde
        self.interest = rate

    # Can deposit money into the account
    def deposit(self, Sum):

        self.solde = self.solde + float(Sum)

    # Can withdraw money from the account
    def withdraw(self, Amount):

        self.solde = self.solde - float(Amount)

    # Displays account information 
    def display(self):

        return "The solde of the Bank account " + str(self.name) + " is " + str(self.solde) + " $."
    
    # Change the interest rate of the account     
    def changeRate(self, value):
        self.interest = value

    # Capitalise on the account after a certain number of months
    def capitalisation(self, numMonth):
        self.solde = self.solde + (((float(self.interest)/100) * int(self.solde)) * int(numMonth))

        return "Capitalisation on " + str(numMonth) + " months at the monthly rate of " + str(self.interest) + " %."
