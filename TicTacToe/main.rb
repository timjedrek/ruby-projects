#control the game play
class Game

  def initialize 
      @board = Board.new
      @player_1 = Player.new(name = "", symbol = "X", @board)
      @player_2 = Player.new(name = "", symbol = "O", @board)
      @current_player = @player_1
      @waiting_player = @player_2
      puts 'Player 1 will be "X". Please enter your name'
      @player_1.name = gets.chomp
      puts 'Player 2 will be "O". Please enter your name'
      @player_2.name = gets.chomp
  end
    
  def play
    @board.show
    until game_over
      player_move
      switch_player
    end
    play_again
  end

  def game_over
    game_won || draw
  end

  def game_won
    if @board.winning_combo?
      puts "#{@waiting_player.name} has won the game!"
      true
    else
      false
    end
  end

  def draw
    if @board.full?
      puts "It's a tie"
      true
    else 
      false
    end
  end

  def switch_player
    if @current_player == @player_1
      @current_player = @player_2
      @waiting_player = @player_1
    else
      @current_player = @player_1
      @waiting_player = @player_2
    end
  end

  def player_move
    input = @current_player.get_input(@current_player.name)
      if @board.move_available?(input.to_i, @current_player.symbol, @waiting_player.symbol)
        @board.place_symbol(input.to_i, @current_player.symbol)
      else
        until @board.move_available?(input.to_i, @current_player.symbol, @waiting_player.symbol)
          puts "Cell number #{input} is taken. Try again."
          input = @current_player.get_input(@current_player.name)
        end
        @board.place_symbol(input.to_i, @current_player.symbol)
      end
    @board.show
    puts "#{@current_player.name} entered #{input}"
  end

  VALID_PLAY_AGAIN_RESPONSE = ["y","Y","n","N"]

  def valid_play_again_response?(input)
    VALID_PLAY_AGAIN_RESPONSE.include? input
  end

  def play_again
    puts "Play again? (Y/N)"
    input = gets.chomp.to_s

    
    if valid_play_again_response?(input)
      handle_play_again_response(input)
    else
      until valid_play_again_response?(input)
        puts "Please enter Y or N"
        input = gets.chomp.to_s
      end
      handle_play_again_response(input)
    end
  end

  def handle_play_again_response(input)
      if input == "y" || input ==  "Y"
        puts "Let's play again!"
        @board.reset
        @current_player = @player_1
        play
      elsif input == "n" || input == "N"
        puts "Have a nice day!"
      end
  end

end

#manage all player functionality
class Player
  
  attr_accessor :name, :symbol

  def initialize(name, symbol, board)
    @name = name
    @symbol = symbol
    @board = board
  end
  
  def get_input(player)
      
    puts "#{player} please enter a move"
    x = gets.chomp
    if valid?(x)
      x
    else
      until valid?(x)
        puts "Try again.  #{x} is not valid.  #{player} please enter a move" 
        x = gets.chomp
      end
      x
    end

  end

  def valid?(number_input)
    if valid_range?(number_input.to_i)
      true
    else
      false
    end
  end

  def valid_range?(number_input)
    if number_input > 0 && number_input <=9
      true
    else
      false
    end
  end
end


#maintains the board state
class Board

  attr_reader :cells

  def initialize
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def show
    puts <<-HEREDOC
     #{cells[0]} | #{cells[1]} | #{cells[2]}
     ---+---+---
     #{cells[3]} | #{cells[4]} | #{cells[5]}
     ---+---+---
     #{cells[6]} | #{cells[7]} | #{cells[8]}
    HEREDOC
  end

  def place_symbol(cell_number, current_symbol)
    @cells[cell_number - 1] = current_symbol
  end

  def move_available?(cell_number, current_symbol, waiting_symbol)
    if (@cells[cell_number - 1] == current_symbol) || (@cells[cell_number - 1] == waiting_symbol)
      false
    else
      true
    end
  end
    
  def full?
    cells.all? { |cell| cell =~ /[^0-9]/ }
  end

  
  WINNING_COMBOS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
  [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
  ]

  def winning_combo?
    WINNING_COMBOS.any? do |valid|
        [cells[valid[0]], cells[valid[1]], cells[valid[2]]].uniq.length == 1
    end
  end

  def reset
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end
end

g = Game.new
g.play