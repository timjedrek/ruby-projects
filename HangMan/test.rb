class Board
    attr_accessor :tries, :selected_letters, :chosen_word

  def initialize
    @tries = 10
    @selected_letters = []
    @chosen_word = ""
    choose_word
    show_lines(@chosen_word)
  end

  def choose_word
    word = File.readlines("word_bank.txt").sample.strip
      until word.length >= 4
      word = File.readlines("word_bank.txt").sample.strip
      end
      @chosen_word = word
    end

  def show_lines(input)
    number_of_letters = @chosen_word.length
    puts input
    puts number_of_letters
  end

end

a = Board.new