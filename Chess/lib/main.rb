# Flow outline
# welcome message
# menu
  # new game
  # load game
  # save game
  # end game
  # resume game
  # help

# new game
  # Human vs Human
  # Human vs Computer
    # make a class for player
    # if computer, another a computer class will inherit player class and contain logic for random moves

# at anytime, menu can be accessed so menu should be a "higher" class
# for save, export board data to YAML /JSON
# during game, player selects a piece
# board highlights what moves are available for that peice
# player selects the move
# piece moves
# peices move and get removed throughout game
# make alert for when in check
# need to make castle an option when available
# once in checkmate game ends
# or stalemate if only kings remain and 10 moves each elapses

require_relative 'main_menu'
require_relative 'format'

# Class to hold the game
class Game
  include MainMenu

  attr_accessor :player

  def initialize
    @player = player
    main_menu
  end

  def play_game
    puts 'You chose to play the game'
  end

  def load_game
    puts 'You chose to load the game'
  end

  def save_game
    puts 'You chose to save the game'
  end

  def end_game
    puts 'You chose to end the game'
  end

  def resume_game
    puts 'You chose to resume the game'
  end

  def help
    puts 'You need help'
  end

end

Game.new
