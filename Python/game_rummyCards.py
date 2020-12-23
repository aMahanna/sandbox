import random

def make_deck(rankNumber):  
    '''(int)->list of int
        Returns a list of integers representing the strange deck with num ranks.

    >>> deck=make_deck(13)
    >>> deck
    [101, 201, 301, 401, 102, 202, 302, 402, 103, 203, 303, 403, 104, 204, 304, 404, 105, 205, 305, 405, 106, 206, 306, 406, 107, 207, 307, 407, 108, 208, 308, 408, 109, 209, 309, 409, 110, 210, 310, 410, 111, 211, 311, 411, 112, 212, 312, 412, 113, 213, 313, 413]

    >>> deck=make_deck(4)
    >>> deck
    [101, 201, 301, 401, 102, 202, 302, 402, 103, 203, 303, 403, 104, 204, 304, 404]
    
    '''
    # Declare variables 
    deck = []
    suit = [100, 200, 300, 400]
    rank = []

    # Append rank list based on user input
    for t in range(1, rankNumber+1):
        rank.append(t)

    # Appends deck using suit and rank list
    for i in range(0, len(suit)):
        for j in range(0, len(rank)):
            deck.append(suit[i] + rank[j])
            
    print("You are playing with a deck of " + str(len(deck)) + " cards.")
    return deck

def shuffle_deck(deck):
    '''(list of int)-> list of int
       Shuffles the given list of strings representing the playing deck

    Here you should use random.shuffle function from random module.
    
    Since shufflling is random, exceptionally in this function
    your output does not need to match that show in examples below:

    >>> deck=[101, 201, 301, 401, 102, 202, 302, 402, 103, 203, 303, 403, 104, 204, 304, 404]
    >>> shuffle_deck(deck)
    >>> deck
    [102, 101, 302, 104, 304, 103, 301, 403, 401, 404, 203, 204, 303, 202, 402, 201]
    >>> shuffle_deck(deck)
    >>> deck
    [402, 302, 303, 102, 104, 103, 203, 301, 401, 403, 204, 101, 304, 201, 404, 202]
    '''

    # Shuffles and returns deck
    random.shuffle(deck, random.random)
    return deck 
    

def deal_cards_start(deck):
    '''(list of int)-> list of int
     Returns a list representing the player's starting hand.
     It is  obtained by dealing the first 7 cards from the top of the deck.
     Precondition: len(dec)>=7
    '''

    # Declare player's hand variable
    player = []
    for w in range (1, 8):
        player.append(deck[-w]) # Grabs cards from top of the deck (last in list)
        
    for m in range(-7, 0):
        del deck[m] # Deletes last 7 cards from deck 

    return player


def deal_new_cards(deck, player, num):
    '''(list of int, list of int, int)-> None
    Given the remaining deck, current player's hand and an integer dice num,
    the function deals num cards to the player from the top of the deck.
    If  the number  of cards in the deck is less than num then then all the remaining cards are from the deck.
    Precondition: 1<=num<=6l deck and player are disjoint subsets of the strange deck. 
    
    >>> deck=[201, 303, 210, 407, 213, 313]
    >>> player=[302, 304, 404]
    >>> deal_new_cards(deck, player, 4)
    >>> player
    [302, 304, 404, 313, 213, 407, 210]
    >>> deck
    [201, 303]
    >>>

    >>> deck=[201, 303]
    >>> player=[302, 304, 404]
    >>> deal_new_cards(deck, player, 4)
    >>> player
    [302, 304, 404, 303, 201]
    >>> deck
    []
    '''

    # Adds new cards to the hand, depending on the number of cards left in the deck vs dice num rolled
    if (num < len(deck)):
        for y in range (1, num+1):
            player.append(deck[-y]) # grabs from top of the deck (last in list)
            
        for m in range(-num, 0):
            del deck[m] # Deletes added cards from deck
            
        print(str(num) + " cards have been added to your hand from the top of the deck.")
        
    else:
        for y in range (1, len(deck)+1):
            player.append(deck[-y]) # grabs from top of the deck (last in list)
            
        for m in range(-len(deck), 0):
            del deck[m] # Deletes last cards from deck
            
        print("The remaining of the deck has been added to your hand, since the number of cards remaining is less than (or equal to) the rolled dice.")
        
    return player

def print_deck_twice(player):
    '''(list)->None
    Prints elements of a given list deck in two useful ways.
    First way: sorted by suit and then rank.
    Second way: sorted by rank.
    Precondition: hand is a subset of the strange deck.
    
    Your function should not change the order of elements in list hand.
    You should first make a copy of the list and then call sorting functions/methods.

    Example run:
    >>> a=[311, 409, 305, 104, 301, 204, 101, 306, 313, 202, 303, 410, 401, 105, 407, 408]
    >>> print_deck_twice(a)

    101 104 105 202 204 301 303 305 306 311 313 401 407 408 409 410 

    101 301 401 202 303 104 204 105 305 306 407 408 409 410 311 313 
    >>> a
    [311, 409, 305, 104, 301, 204, 101, 306, 313, 202, 303, 410, 401, 105, 407, 408]

    '''

    
    # Declare variables 
    player.sort() # Sorting player will facilitate the reading of the user's hand to spot different melds
    allLastTwoDigits = []
    uniqueLastTwoDigits = []
    sortRankOnly = []
    
    print("\nHere is your hand printed in two ways\n")
    # FIRST WAY
    for element in player:
        print(element, end = ' ') # Prints the hand in a sorted version (by SUIT THEN RANK) to help identify PROGRESSIONS
        allLastTwoDigits.append(element % 100) # Appends all last two digits from every single element in player
    
    # SECOND WAY
    for i in range(0, len(allLastTwoDigits)): # Loops through the whole list of every Last Two Digits (even reoccuring)
        if (allLastTwoDigits[i] not in uniqueLastTwoDigits): # Adds all UNIQUE Last Two Digit values to a new list
            uniqueLastTwoDigits.append(allLastTwoDigits[i])

    uniqueLastTwoDigits.sort()
    for w in range(0, len(uniqueLastTwoDigits)): # Loops firstly through the length of uniqueLastTwoDigits then length of player's hand

        for i in range(0, len(player)):

            if (uniqueLastTwoDigits[w] == player[i] % 100): # Verifies if the specific uniqueLastTwoDigit matches with the last two digits of the specific element in hand
                sortRankOnly.append(player[i]) # Creates list organized by rank only
                
    print("\n\n")
    for element in sortRankOnly:
        print(element, end = ' ') # Finally displays the second way to user


def is_valid(cards, player):
    '''(list of int, list of int)->bool
    Function returns True if every card in cards is the player's hand.
    Otherwise it prints an error message and then returns False,
    as illustrated in the followinng example runs.

    Precondition: cards and player are subsets of the strange deck.
    
    >>> is_valid([210,310],[201, 201, 210, 302, 311])
    310 not in your hand. Invalid input
    False

    >>> is_valid([210,310],[201, 201, 210, 302, 310, 401])
    True
    '''

    # Validates if all integers from user input is in player's hand
    for i in range(0, len(cards)):
        if (cards[i] in player):
            isValid = True
        else:
            isValid = False
            print(str(cards[i]) + " is not in your hand. Invalid input.") # Identifies which card is not in player's hand if needed
            return isValid

    return isValid

def is_discardable_kind(cards):
    '''(list of int)->True
    Function returns True if cards form 2-, 3- or 4- of a kind of the strange deck.
    Otherwise it returns False. If there  is not enough cards for a meld it also prints  a message about it,
    as illustrated in the followinng example runs.
    
    Precondition: cards is a subset of the strange deck.

    In this function you CANNOT use strings except in calls to print function. 
    In particular, you cannot conver elements of cards to strings.
    
    >>> is_discardable_kind([207, 107, 407])
    True
    >>> is_discardable_kind([207, 107, 405, 305])
    False
    >>> is_discardable_kind([207])
    Invalid input. Discardable set needs to have at least 2 cards.
    False
    '''
    # Variable bool to evaluate meld
    aKind = False
    cards.sort()
    count = 1
    for i in range(1, len(cards)): 
        if (cards[i-1] % 100 == cards[i] % 100): # Verifies if all cards share the same last two digits
            aKind = True
            count += 1 
        else:
            aKind = False # If bool False turns up even once, it is no longer a match
            
            return aKind

    if (count < 2): 
        print("INVALID INPUT. Discardable set needs to have at least 2 cards")
        
        
    return aKind


def is_discardable_seq(cards):
    '''(list of int)->True
    Function returns True if cards form progression of the strange deck.
    Otherwise it prints an error message and then returns False,
    as illustrated in the followinng example runs.
    Precondition: cards is a subset of the strange deck.

    In this function you CANNOT use strings except in calls to print function. 
    In particular, you cannot conver elements of cards to strings.

    >>> is_discardable_seq([313, 311, 312])
    True
    >>> is_discardable_seq([311, 312, 313, 414])
    Invalid sequence. Cards are not of same suit.
    False
    >>> is_discardable_seq([201, 202])
    Invalid sequence. Discardable sequence needs to have at least 3 cards.
    False
    >>> is_discardable_seq([])
    Invalid sequence. Discardable sequence needs to have at least 3 cards.
    False
    '''

    # Declares variables and sorts cards
    aProgression = False
    count = 1
    cards.sort()
    for i in range(1, len(cards)):
        if (cards[i-1] == cards[i] -1): # Verifies that the previous int in cards matches a progression with the next
            count += 1 
            aProgression = True
        else:
            aProgression = False
            print("INVALID SEQUENCE. Cards are either not of same suit/do not form a progression") # If there is a break of sequence, returns false with a message to user
            return aProgression

    if (count < 3 and aProgression == True): # Evaluates edge cases to make sure the progression consists of 3+ cards
        print("INVALID SEQUENCE. Discardable sequence needs to have at least 3 cards")
        aProgression = False
        
    return aProgression

def rolled_one_round(player):
    '''(list of int)->None
    This function plays the part when the player rolls 1
    Precondition: player is a subset of the strange deck

    >>> #example 1:
    >>> rolled_one_round(player)
    Discard any card of your choosing.
    Which card would you like to discard? 103
    103
    No such card in the deck. Try again.
    Which card would you like to discard? 102

    Here is your new hand printed in two ways:

    201 212 311 

    201 311 212 

    '''


    print("\nDiscard any card of your choosing")
    discardCard = int(input("Which card would you like to discard?: "))

    while (discardCard not in player):
        print("No such card in your hand. Try again") 
        discardCard = int(input("Which card would you like to discard?: ")) # Endless loop to prevent errors from edge cases 

    player.remove(discardCard) # Removes card from user's hand
    

def rolled_nonone_round(player):
    '''(list of int)->None
    This function plays the part when the player rolls 2, 3, 4, 5, or 6.
    Precondition: player is a subset of the strange deck

    >>> #example 1:
    >>> player=[401, 102, 403, 104, 203]
    >>> rolled_nonone_round(player)
    Yes or no, do you  have a sequences of three or more cards of the same suit or two or more of a kind? yes
    Which 3+ sequence or 2+ of a kind would you like to discard? Type in cards separated by space: 102 103 104
    103 not in your hand. Invalid input
    Yes or no, do you  have a sequences of three or more cards of the same suit or two or more of a kind? yes
    Which 3+ sequence or 2+ of a kind would you like to discard? Type in cards separated by space: 403 203

    Here is your new hand printed in two ways:

    102 104 401 

    401 102 104 
    Yes or no, do you  have a sequences of three or more cards of the same suit or two or more of a kind? no

    >>> #example 2:
    >>> player=[211, 412, 411, 103, 413]
    >>> rolled_nonone_round(player)
    Yes or no, do you  have a sequences of three or more cards of the same suit or two or more of a kind? yes
    Which 3+ sequence or 2+ of a kind would you like to discard? Type in cards separated by space: 411 412 413

    Here is your new hand printed in two ways:

    103 211 

    103 211 
    Yes or no, do you  have a sequences of three or more cards of the same suit or two or more of a kind? no

    >>> #example 3:
    >>> player=[211, 412, 411, 103, 413]
    >>> rolled_nonone_round(player)
    Yes or no, do you  have a sequences of three or more cards of the same suit or two or more of a kind? yes
    Which 3+ sequence or 2+ of a kind would you like to discard? Type in cards separated by space: 411 412
    Invalid meld: 11 is not equal to 12
    Invalid sequence. Discardable sequence needs to have at least 3 cards.

    >>> #example 4:
    >>> player=[401, 102, 403, 104, 203]
    >>> rolled_nonone_round(player)
    Yes or no, do you  have a sequences of three or more cards of the same suit or two or more of a kind? alsj
    Yes or no, do you  have a sequences of three or more cards of the same suit or two or more of a kind? hlakj
    Yes or no, do you  have a sequences of three or more cards of the same suit or two or more of a kind? 22 33
    Yes or no, do you  have a sequences of three or more cards of the same suit or two or more of a kind? no
    '''


    canMeld = ' '
    while canMeld == ' ':
        canMeld = input("\n\nYes or no, do you have a sequences of three or more cards of the same suit or two or more of a kind?: ")

        if (canMeld == "yes"):
            userAnswer = input("Which 3+ sequence or 2+ of a kind would you like to discard? Type in cards separated by space: ")
            cards = [int(element) for element in userAnswer.split(' ')] # Creates a list (cards) with the integers from user input
            
            while (is_valid(cards, player) != True):
                userAnswer = input("Which 3+ sequence or 2+ of a kind would you like to discard? Type in cards separated by space: ") # Repeats until user answers properly
                cards = [int(element) for element in userAnswer.split(' ')] 

            
            if(is_discardable_kind(cards) == True or is_discardable_seq(cards) == True): #If one the melds can be created, remove the user input integers from list
                for element in cards:
                    player.remove(element)
            
            
            print_deck_twice(player) # Displays new hand
            canMeld = ' ' # Resets the loop if user has more cards to discard
            
        elif (canMeld == "no"): # Breaks and goes to the next round 
            return 

        else:
            canMeld = ' ' # If user inputs anything else other than 'yes' or 'no', the loop repeats
                

def main():
    '''Combines all data collected from previous functions above to structure the game. Returns nothing'''
    
    roundNum = 1 # Initiates first round
    print("Welcome to Single Player Rummy with Dice and strange deck.\n")
    rankChange=input("The standard deck  has 52 cards: 13 ranks times 4 suits.\nWould you like to change the number of cards by changing the number of ranks? ").strip().lower()

    if (rankChange == "yes"):
        rankNumber = int(input("Enter a number between 3 and 99, for the number of ranks: ")) # User can change number of ranks in deck
        
        while(rankNumber < 3 or rankNumber > 99): # Loop to prevent error from edge case
            rankNumber = int(input("Enter a number between 3 and 99, for the number of ranks: "))
                
    else:
        rankNumber = 13

    # Call functions to make & shuffle deck, deal 7 cards from top of the list and display to user 
    baseDeck = make_deck(rankNumber)
    strangeDeck = shuffle_deck(baseDeck)
    player = deal_cards_start(strangeDeck)
    showHand = print_deck_twice(player)

    # MAIN LOOP (STEP 2) - Repeats until user has no more cards in hand 
    while (len(player) > 0):
        print("\n\nWELCOME TO ROUND " + str(roundNum)) #Initiates new rounds

        num = int(6*random.random()+1) # Generates dice number 
        if (len(strangeDeck) == 0): # Dice number becomes 1 if deck is empty and user cannot find melds anymore
            num = 1
        print("\nYou rolled the dice and it shows: " + str(num))
        
        player = deal_new_cards(strangeDeck, player, num) # Deals new cards and displays hand 
        showHand = print_deck_twice(player)

        # Executes respected function based on dice number
        if num == 1: 
            rolled_one_round(player)
        else:
            rolled_nonone_round(player)
        
        print("ROUND " + str(roundNum) + " COMPLETED.") # Ends round after respected function finishes
        roundNum += 1

    print("CONGRATULATIONS, YOU COMPLETED THE GAME IN " + str(roundNum-1) + " ROUND(S).") # Loop breaks

main()


  
