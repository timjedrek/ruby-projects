require_relative "drawings.rb"
require_relative "format.rb"

class Game

  def start
    welcome
    main_menu
  end

  def main_menu
    puts "Please choose an option".italic
    show_mm_selection
    input = gets.chomp
    mm_selection_handler(input)
  end

  def show_mm_selection
    puts "1 - Play new"
    puts "2 - Load file"
    puts "3 - Save file"
    puts "4 - End game"
  end

  def mm_selection_handler(input)
    case input.to_i
    when 1
      play_game
    when 2
      load_game
    when 3
      save_game
    when 4
      end_game
    else
      validate_mm_selection(input)
    end
  end

  def play_game
    puts "you chose to play the game"
    puts 'at anytime, if you want to access the menu type "MENU"'
    #sleep(2)
    play
  end

  def load_game
    puts "you chose to load the game"
  end

  def save_game
    puts "you chose to play the game"
  end

  def end_game
    puts "you chose to end the game"
    puts "Goodbye!"
  end

  def validate_mm_selection(input)
    puts "Try again. #{input} is not valid. Enter a number between 1-4"
    show_mm_selection
    new_input = gets.chomp
    mm_selection_handler(new_input)
  end

  def play
    @board = Board.new
    @player = Player.new
  end
end

class Board

  attr_accessor :tries, :selected_letters, :chosen_word

  def initialize
    @tries = 10
    @selected_letters = []
    @chosen_word = ""
    choose_word
    show
  end

def choose_word
  word = File.readlines("word_bank.txt").sample.strip

    until word.length >= 4
        word = File.readlines("word_bank.txt").sample.strip
    end
   @chosen_word = word
end

  def show
    show_drawing(@tries)
    show_lines
    show_tries
    show_guessed_letters
  end

  def show_drawing(tries)
    case tries.to_i
    when 10
      position_1
    when 9
      position_2
    when 8
      position_3  
    when 7
      position_4  
    when 6
      position_5  
    when 5
      position_6  
    when 4
      position_7  
    when 3
      position_8  
    when 2
      position_9  
    when 1
      position_10  
    when 0
      position_11
    end
  end

  def show_lines
    number_of_letters = @chosen_word.length
    puts @chosen_word
    
  end

  def show_tries
    puts "You have #{@tries.to_s.red} tries left to guess the word!"
  end

  def show_guessed_letters
    puts "These are the letters you have guessed: "
  end

end

class Player
end

g = Game.new
g.start

#main menu
  #Get user selection
  #put out
    #save file
    #load file
    #play new game
    #end game

#save File
  #get user input for file name
  #output a JSON or YAML file

#output
  #logic to output the file goes here

#load file
  #Display all of the saved files
  #index them
  #ask user for input by index
  #import

#import
  #logic to import the file goes here
  #play

#end game
  #puts Have a nice day


#play

  #Until game over

    #load dictionary txt file

    #pick a random word from the file.
      #go through each row and assign an index
      #total lines is 61406
      #filter for words greater than 5 characters
      #call random number times total lines
      #assign "chosen_word" to the random index
      
    #initiate the board
      #set tries to 10
      #set selected letters to []
      #show the board

    #show the board
      #draw hangman
      #take length of the chosen_word and print _ for each character
      #output the number of tries
      #output the selected letters


    #ask for input
      #display "Please enter a letter to guess"
      #get the input
      #validate it
      #add_letter(input)
      
    #add letter(input)
      #

    #validate_formaat
      #if not valid
        #loop until valid
          #put "Try again.  Enter a letter"
          #get input
          #validate it
          #add to selected letters
          #update board

    #validate_if_already_guessed(input for letter guess)
      #if input is in the array selected letters
        #false

    #validate format(input for letter guess)
      #if not a single letter
        #false
        #one method I am thinking for validation is to convert the input to ascii and then ensure the range is correct

  #game_over?
    #guessed correctly?
      #congratualtory message
      #play again
    #no_more_tries?
      #loser message
      #play again?
  
  #guessed_correctly
    #if board.flat = chosen_word
      #true
      

  #no_more_tries
    #if tries = 0
      #true
  
  #play again
    #output play again
    #get Y or N input
      #validate YN
        #if not valid
          #puts try again
          #get YN input
  
  #validate YN
    #make sure its Y, y, N, n
      #return true or false
