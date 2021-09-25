from random import shuffle

class Blackjack:
 values={'1':1,'2':2,'3':3,'4':4,'5':5,'6':6,'7':7,'8':8,'9':9,'10':10,'J':10,'Q':10,'K':10,'A':11}
  
 def play(self):
  '''play a game'''   
  d = GameOfCards()
  d.mix()
  
  bank = Hand('Bank')
  player = Hand('Player')
  # gives two cards to the player and two to the bank
  for i in range(2):  
    player.addCard(d.getCard())
    bank.addCard(d.getCard())

  # show the hands
  bank.showHand()
  player.showHand()

  # as long as the player ask for a Card!, The bank gets cards
  response = input('\nCard? yes or no? (By default yes) ')
  while response in ['','y','Y','yes','Yes']:
    c = d.getCard()
    print("You have added:")
    print(c)
    player.addCard(c)
    if self.total(player) > 21:
       print("\nYou have passed 21. You have lost.")
       return   
    response = input('\nCard? Yes or no? (By default yes)')

  # the bank play with those rules  
  while self.total(bank) < 17:
    c = d.getCard()
    print("The bank has added:")
    print(c)
    bank.addCard(c)
    if self.total(bank) > 21:
       print("\nThe bank has passed 21. You have won!")
       return

  # if 21 is has not been passed, compare the hands to find the winner  
  self.compare(bank, player)

      
 def total(self, hand):
    ''' (Main) -> int
    calculate the sum of all the cards' values in the hand
    '''

    total = 0
    numAce = 0
    # calculate the sum of all the cards' values in the hand
    for i in hand.cards:
        total += self.values[i.value]
        if(i.value == 'A'):
            numAce += 1

    # while the sum > 21 and there are Ases, deduct 10 points for each As
    while (total > 21 and numAce > 0):
        total -= 10
        numAce -= 1

    return total # to be changed

 def compare(self, bank, player):
    ''' (Main, Main) -> None
    Compare the main of the player with the hand of the bank
    et affiche de messages
    '''

    # Bank's total is higher
    if(self.total(bank) > self.total(player)):
        print("You have lost.")
    elif(self.total(bank) < self.total(player)): # Player's total is higher
        print("You have won.")
    else: # Verifies if either the bank or the player have a proper blackjack (if not it is a tie)
        if((bank.cards[0].value in ['10','J','Q','K'] and bank.cards[1].value == 'A') or (bank.cards[1].value in ['10','J','Q','K'] and bank.cards[0].value == 'A')):
            print("You have lost.")
        elif((player.cards[0].value in ['10','J','Q','K'] and player.cards[1].value == 'A') or (player.cards[1].value in ['10','J','Q','K'] and player.cards[0].value == 'A')):
            print("You have won.")
        else:
            print("Equality.")

       
class Hand(object):
    '''represents a main of cards to play'''

    def __init__(self, player):
        '''(Main, str)-> none
        initializes the player's name and the card list with list being empty'''
        self.player = player # Initializes player
        self.cards = [] # Initializes hand

    def addCard(self, card):
        '''(Main, Card) -> None
        add a card to the hand'''
        self.cards.append(card) # Appends a card to the self.cards list (your hand)

    def showHand(self):
        '''(Main)-> None
        display the player's name and the hand'''
        # Displays names
        print(self.player+":", end="\t")

        # Loops through the player's cards and displays the value + color
        for i in self.cards:
            print(i.value+" "+i.color, end=" ")
        print()
        
                
    def __eq__(self, other):
        '''returns True if the hands have the same cards in the same order'''

        # Check if the lengths are equal first 
        if(len(self.cards)!= len(other.cards)):
            return False

        # Loops through each card to see if they are equivalent
        eq = False
        for i in range(len(self.cards)):
            if (self.cards[i] == other.cards[i]):
                eq == True
            else:
                return False
                
        # This will return True
        return eq

    def __repr__(self):
        '''returns a representation of the object'''
        print("Hand(%s, "+self.cards +")" % self.player)

class Card:
    '''represente a card to play'''

    def __init__(self, value, color):
        '''(Carte,str,str)->None        
        initializes the value and the color of the card'''
        self.value = value
        self.color = color  # spade, heart, club or diamond

    def __repr__(self):
        '''(Carte)->str
        returns the representation of the object'''
        return 'Card('+self.value+', '+self.color+')'

    def __eq__(self, other):
        '''(Card,Card)->bool
        self == other if the value and color are the same'''
        return self.value == other.value and self.color == other.color

class GameOfCards:
    '''represente the game of 52 cards'''
    # values and colors are variables of class
    values = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']
    colors = ['\u2660', '\u2661', '\u2662', '\u2663']
    # colors is a set of 4 symbols Unicode that represents the 4 colors
    # spade, heart, club ou diamond
    
    def __init__(self):
        'initializes the packet of 52 cards'
        self.packet = []          # packet is empty at the start
        for color in self.colors: 
            for value in GameOfCards.values: # variables of the class
                # add a card of value and color
                self.packet.append(Card(value,color))

    def getCard(self):
        '''(GameOfCards)->Card
        distribute a card, the first from the packet'''
        return self.packet.pop()

    def mix(self):
        '''(GameOfCards)->None
        to mix the card game'''
        shuffle(self.packet)

    def __repr__(self):
        '''returns a representation od the object'''
        return 'Packet('+str(self.packet)+')'

    def __eq__(self, other):
        '''return True if the packets are the same cards in the same order'''
        return self.packet == other.packet
    
    
b = Blackjack()
b.play()

