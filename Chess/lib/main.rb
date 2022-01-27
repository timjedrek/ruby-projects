# frozen_string_literal: true

require_relative 'menus'
require_relative 'format'
require_relative 'board'
require_relative 'player'

# Class to hold the game
class Game
  include Menus

  def initialize
    @board = Board.new
    @player_one = Player.new
    @player_two = Player.new
    main_menu
  end

  def play_game
    puts 'You chose to play the game'
    sleep(1)
    player_selection_menu
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
