require_relative "drawings.rb"
require_relative "format.rb"
require "yaml"

class Game
    include Welcome
    attr_accessor :board, :started

  def initialize
    @@board = Board.new
    @@started = false
  end

  def start
    puts `clear`
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
    puts "1 - Play new game"
    puts "2 - Load file"
    puts "3 - Save file"
    puts "4 - End game"
    puts "5 - Resume game"
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
    when 5
      resume_game
    else
      validate_mm_selection(input)
    end
  end

  def play_game
    puts "You chose to play a new game"
    puts 'At anytime, if you want to access the menu type "MENU"'
    sleep(2)
    @@started = true
    @@board = Board.new
    @@board.play
    start
  end

  def load_game
    puts "You chose to load the game"
    puts `clear`
    filename = choose_game
    saved = File.open(File.join(Dir.pwd, filename), 'r')
    @@board = YAML.load(saved)
    saved.close
    @@started = true
    @@board.play
  end

  def choose_game
    begin
      puts "Here are the current saved games. Please choose which you'd like to load."
      filenames = Dir.glob('save_files/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
      puts filenames
      filename = gets.chomp
      raise "#{filename} does not exist.".red unless filenames.include?(filename)
      puts "#{filename} loading!"
      puts
      "/save_files/#{filename}.yaml"
    rescue StandardError => e
      puts e
      retry
    end
  end

  def save_game
    if game_started?
      puts "You chose to save the game"
      puts `clear`
      puts "Please enter save file name:"
      save_name = gets.chomp
      cleaned_name = sanitize(save_name)
      File.new "save_files/#{cleaned_name}.yaml","w"
      dump = YAML.dump(@@board)
      File.open(File.join(Dir.pwd, "/save_files/#{cleaned_name}.yaml"), 'w') { |file| file.write dump }
      resume_game
    else
      not_started
    end
  end

  def sanitize(filename)
    # Remove any character that aren't 0-9, A-Z, or a-z
    filename.gsub(/[^0-9A-Z]/i, '_')
  end

  def not_started
    puts "No game has been started yet"
    sleep(1)
    start
  end

  def end_game
    puts "You chose to end the game"
    abort "Goodbye!"
  end

  def resume_game
    if game_started?
      puts "Resuming the game"
      sleep(1)
      @@board.play
    else    
      not_started
    end
  end

  def game_started?
    if @@started == false
      false
    else
      true
    end
  end

  def validate_mm_selection(input)
    puts "Try again. #{input} is not valid. Enter a number between 1-5"
    show_mm_selection
    new_input = gets.chomp
    mm_selection_handler(new_input)
  end
end

class Board < Game
  include Drawings
  attr_accessor :tries, :selected_letters, :chosen_word

  #using initialize as a reset
  def initialize
    @tries = 10
    @selected_letters = []
    @incorrect_letters = []
    @chosen_word = ""
    @guessed_word = ""
    choose_word
  end

  def play
    until game_over?
      puts `clear`
      show
      #puts @chosen_word (use this if you want to cheat)
      get_letter_guess
    end
    initialize
    @@started = false
  end

  def choose_word
    word = File.readlines("word_bank.txt").sample.strip

    until word.length >= 4
        word = File.readlines("word_bank.txt").sample.strip
    end
    @chosen_word = word.upcase
    @guessed_word = "- " * @chosen_word.length
  end

  def show
    show_drawing(@tries)
    show_lines
    show_tries
    show_guessed_letters
  end

  def show_lines
    puts @guessed_word
  end

  def show_tries
    puts "You have #{@tries.to_s.red} tries left to guess the word!"
  end

  def show_guessed_letters
    puts "These are the incorrect letters you have guessed: #{format_incorrect_letters(@incorrect_letters)}"
  end

  def format_incorrect_letters(an_array)
    @incorrect_letters.join(", ")
  end

  def get_letter_guess
    user_guess = gets.chomp.upcase
    if user_guess == "MENU"
      start
    elsif valid_guess?(user_guess)
      check_guess(user_guess.upcase)
    else 
      until valid_guess?(user_guess)
        puts "Try again. #{user_guess} is not a valid input."
        user_guess = gets.chomp
        start if user_guess == "MENU"
      end
      check_guess(user_guess.upcase)
    end
  end

  def valid_guess?(input)
    if correct_format?(input) && new_letter?(input)
      true
    else
      false
    end
  end

  def correct_format?(input)
    if input.to_s.length == 1
      if input.match?(/[A-Za-z]/)
        true
      else
        false
      end
    else
      false
    end
  end

  def new_letter?(input)
    input = input.upcase
    if @selected_letters.include? input
      false
    else
      true
    end
  end

  def check_guess(input)
    match = 0
    @selected_letters << input
    @chosen_word.split("").each do |letter|
      match += 1 if letter == input 
    end

    if match > 0
      correct_guess(input)
    else
      incorrect_guess(input)
    end
  end

  def correct_guess(input)
    count = 0
    split_guess_word = @guessed_word.split(" ")

        @chosen_word.split("").each do |letter|
          split_guess_word[count] = letter if letter == input
          count += 1
        end

        @guessed_word = split_guess_word.join(" ")
  end

  def incorrect_guess(input)
    @tries -= 1
        @incorrect_letters << input
  end

  def game_over?
    if @tries == 0
      puts `clear`
      show
      puts "Sorry.  You lost.  The word was #{@chosen_word}"
      sleep(3)
      true
    elsif @guessed_word.delete(" ") == @chosen_word
      puts `clear`
      show
      puts "Congrats!.  You won."
      sleep(3)
      true
    else
      false
    end
  end
end

g = Game.new
g.start