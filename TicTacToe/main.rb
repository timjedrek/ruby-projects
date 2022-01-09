class Board
    @@rows = [
      %w[1 2 3],
      %w[4 5 6],
      %w[7 8 9]
    ]
  
    def self.rows
      @@rows
    end
  
    def self.show
      (@@rows.length - 1).times do |i|
        puts "\t\s #{rows[i].join(' | ')}"
        puts "\t ---+---+---"
      end
      puts "\t\s #{rows[2].join(' | ')}"
      puts "\n"
    end
  
    def self.reset
      @@rows = [
        %w[1 2 3],
        %w[4 5 6],
        %w[7 8 9]
      ]
    end
  
    def self.check_winners
      cells = rows.flatten
      valid_wins = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
        [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
      ]
  
      valid_wins.any? do |valid|
        [cells[valid[0]], cells[valid[1]], cells[valid[2]]].uniq.length == 1
      end
    end
  
    def self.check_tie
      rows.flatten.all? { |x| x =~ /\D/}
    end
  end
  
  # Class containing method to check for correct input
  class InputCheck
    def self.valid(num)
      if integer?(num)
        if num.to_i.positive? && num.to_i < 10
          case num.to_i
          when (1..3) then return row_check(num, 0)
          when (4..6) then return row_check(num, 1)
          when (7..9) then return row_check(num, 2)
          end
        end
        return 'ERRNUM'
      end
      'NAN'
    end
  
    class << self
      private
  
      def row_check(num, row)
        if Board.rows[row].include?(num)
          row
        else
          false
        end
      end
  
      def integer?(num)
        num.to_i.to_s == num
      end
    end
  end
  
  # Contains method for playing an input
  class Player
    attr_reader :name, :char
  
    @@played = false
    def initialize(name, char)
      @name = name
      @char = char
    end
  
    def play
      Board.show
      num = input
      check = InputCheck.valid(num)
      case check
      when false then puts "#{name}, Please input a number (1-9), that's still available!"
      when 'NAN' then puts "#{name}, Please input a number between 1 & 9!"
      when 'ERRNUM' then puts "#{name}, Please input a number between 1 & 9, and nothing more or less."
      else update_board(num, check) end
    end
  
    def self.played
      @@played
    end
  
    def self.played=(new)
      @@played = new
    end
  
    private
  
    def input
      puts "#{@name}, Please input a number (1-9), that's still on the board."
      gets.chomp
    end
  
    def update_board(num, row)
      Board.rows[row][Board.rows[row].index(num)] = @char
      @@played = true
    end
  end
  
  # Contains all methods regarding the game
  class Game
    def self.play_game(one, two)
      turn = main_loop(one, two)
      win_text(turn, one, two)
    end
  
    def self.new_player(other = 'none')
      puts 'Player, what is your name?'
      name = gets.chomp
      puts "Hi #{name}, which character do you want to use as your marker?" if other == 'none'
      puts "Hi #{name}, which character do you want to use as your marker? (It can't be #{other})" unless other == 'none'
      mark = gets.chomp
      while mark == other
        puts "It can't be #{mark}, pick something else!"
        mark = gets.chomp
      end
      Player.new(name, mark)
    end
  
    class << self
      private
  
      def main_loop(one, two)
        won = false
        turn = 0
        until won
          turn.zero? ? one.play : two.play
          if Player.played
            turn.zero? ? turn += 1 : turn = 0
            won = Board.check_winners
            if Board.check_tie
              won = Board.check_tie
              turn = 2
            end
          end
          Player.played = false
        end
        turn
      end
  
      def win_text(turn, one, two)
        Board.show
        if turn.zero?
          puts "Congrats #{two.name}, you won this game!"
        elsif turn == 1
          puts "Congrats #{one.name}, you won this game!"
        else
          puts "It's a Tie!"
        end
      end
    end
  end
  
  one = Game.new_player
  two = Game.new_players(one.char)
  
  Game.play_game(one, two)
  Board.reset
  puts 'Do you want to play another round? (y/n)'
  Game.play_game(one, two) if gets.chomp == 'y'