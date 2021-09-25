def eraseTable(tab):
   '''
   (list) -> None
   This function prepares the game table (array) 
   by putting '-' in all the elements.
   It does not create a new array
   Preconditions: tab is a reference to an nxn array matrice n x n that contains '-', 'X' or 'O'
   '''

   for row in range(len(tab)): # Loops through the rows
      for col in range(len(tab[row])): # Loops through the columns

         tab[row][col] = '-' # Resets all elements from the array 
         
      
def verifyWin(tab):
   '''(list) ->  bool
   * Preconditions: tab is a reference to an nxn array that contains '-', 'X' or 'O'
   * Verify if there is a winner.
   * Look for 3 X's and O's in a row, column, and diagonal.
   * If we find one, we display the winner (the message "Player X has won" 
   * or "Player O has won!") and returns True.
   * If there is a draw (verify it with the function testdraw),
   * display "It is a draw" and returns True.
   * If the game is not over, returns False.
   * The function call the functions testrows, testCols, testDiags
   * pour verifier s'il y a un gagnant.
   * Those functions returns the winner 'X' or 'O', or '-' if there is no winner.
   '''

   # Calls all test functions to verifiy a win for Player X
   if (testRows(tab) == 'X' or testCols(tab) == 'X' or testDiags(tab) == 'X'):
      print("Player X has won!") 
      return True

   # Calls all test functions to verifiy a win for Player O
   elif (testRows(tab) == 'O' or testCols(tab) == 'O' or testDiags(tab) == 'O'):
      print("Player O has won!")
      return True

   elif (testDraw(tab) == True): # If the array is filled and no win, calls a draw
      print("It is a draw.")
      return True 

   else: 
      return False # The game is still in play

 
def testRows(tab):
   ''' (list) ->  str
   * verify if there is a winning row.
   * Look for three 'X' or three 'O' in a row.  
   * If they are found, the character 'X' or 'O' is returned, otherwise '-' is returned.
   * Preconditions: tab is a reference to an nxn array that contains '-', 'X' or 'O'
   '''


   for row in range(len(tab)): # Loops through rows

         # Checks all three columns for an equality from that row
         if (tab[row][0] == tab[row][1] == tab[row][2]): 

            if tab[row][0] == 'X': # Belongs to Player X 
               return 'X'
               
            elif tab[row][0] == 'O': # Belongs to Player O
               return 'O'
            
   # No result, game is still in play   
   return '-'

  
  
def testCols(tab):
   ''' (list) ->  str
   * verify a winning column.
   * look for three 'X' or three 'O' in a column.  
   * If it is the case the character 'X' or 'O' is returned, otherwise '-' is returned.
   * Preconditions: tab is a reference to an nxn array that contains '-', 'X' or 'O'
   '''

   for col in range(len(tab)): # Loops through columns 

         # Checks all three rows for an equality from that column
         if (tab[0][col] == tab[1][col] == tab[2][col]):
   
            if (tab[0][col] == 'X'): # Belongs to Player X 
               return 'X'
            
            elif tab[0][col] == 'O': # Belongs to Player O
               return 'O'

   # No result, game is still in play   
   return '-'  

   
def testDiags(tab):
   ''' (list) ->  str
   * Look for three 'X' or three 'O' in a diagonal.  
   * If it is the case, the character 'X' or 'O' is returned
   * otherwise '-' is returned.
   * Preconditions: tab is a reference to an nxn array that contains '-', 'X' or 'O'
   '''

   # Initialize starting row and column variables
   row = 0
   col = 0

   # Verifies first diagonal (from the top-left all the way to the bottom-right)
   if tab[row][col] == tab[row+1][col+1] == tab[row+2][col+2]:
      
      if (tab[row][col] == 'X'): # Belongs to Player X 
         return 'X'

      elif (tab[row][col] == 'O'): # Belongs to Player O
         return 'O'

   # Verifies second diagonal (from the far top-right all the way to the bottom-left)
   elif (tab[row][col+2] == tab[row+1][col+1] == tab[row+2][col]):

      if (tab[row][col+2] == 'X'): # Belongs to Player X 
         return 'X'

      elif (tab[row][col+2] == 'O'): # Belongs to Player O
         return 'O'

   else:
      return '-' # No result, game is still in play
  
  
def testDraw(tab):
   ''' (list) ->  bool
   * verify if there is a draw
   * check if all the array elements have X or O, not '-'.  
   * If we do not find find any '-' in the array, return True. 
   * If there is any '-', return false.
   * Preconditions: tab is a reference to an nxn array that contains '-', 'X' or 'O'
   '''
    
   for row in range(len(tab)): # Loops through rows
      for col in range(len(tab[row])): # Loops through columns

         if (tab[row][col] == '-'):  
            return False # Returns False if array still contains a '-'
         
   return True # Concludes that the array is filled with X's and O's


    
def displayTable(tab):
    '''
    (list) -> None
    Display the game table
    Preconditions: tab is a reference to an n x n array that contains '-', 'X' or 'O'
    The format is: 
        0 1 2
      0 - - O
      1 - X -
      2 - - X
    '''
    # Creates the borders of the table 
    print("   ", end="")
    col = 0
    while col < len(tab): 
      print(col, end="  ")
      col += 1
    print()  
    row = 0
    while row < len(tab):  
      print(row, end="")
      col = 0
      while col < len(tab[row]): 
        print(" ",tab[row][col], end="") # Displays the '-', 'X' and 'O' values from the tab array. 
        col += 1
      print()
      row += 1

def play (tab, player):
    '''
    (list, str) -> None
    Plays a step of the game
    Preconditions: tab is a reference to the n x n tab containing '-', 'X' and 'O'
    The player is X or O
    tab is modified (an elementis changed)
    '''               
    
    valid = False
                 
    while not valid:   
        place = [-1,-1] # Create a table with two elements

        print ("Player ",player, end="")
        while not((0 <= place[0] < len(tab))):
          print("\nPlease provide the row from 0 to", (len(tab)-1), ": ")
          place[0] = int(input("Row: ")) # User inputs row and column to play
        
        while not((0 <= place[1] < len(tab))):
          print("\nPlease provide the columm from 0 to", (len(tab)-1), ": ")
          place[1] = int(input("Column: "))
                   
        if tab[place[0]][place[1]] != '-': # Informs the user that the position is already taken
          print("The position", place[0], place[1], "is occupied"); # Inputs again 
          valid = False 
          
        else:
          valid = True            
          tab[place[0]][place[1]] = player # Put the player in the array
            
def main():
    ''' Initiates the game. Returns nothing. '''
    
    response = input("Start a game? (Y or N): ");

    # Create the game table 
    table = [['-','-','-'],['-','-','-'],['-','-','-']] # The only array used in the program.

    while response == 'y' or response == 'Y': 
          eraseTable(table) # Reprepares the game table (for following rounds)
          displayTable(table) # Displays table
          winner = False  # Initializes the variable winner
          
          while not winner: 
            play(table,'X')  # Ask player X to play
            displayTable(table) # Display the game table
            winner = verifyWin(table)  # Check for a winner
            
            if not winner: # If not, the other player can play
              play(table,'O')  # Ask player O to play
              displayTable(table) # Display the game table
              winner = verifyWin(table)  # Check for a winner
              
          response = input("Start a new game? (Y or N): ") # Asks for a new game

main()
