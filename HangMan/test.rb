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
    letter_split = input.to_s.split("")
    word_hash = {}
    letter_split.each do |i|
      word_hash[i] = "_"
    end
    
    word_hash.each_value do |value|
        print " #{value} "
    end

    puts @chosen_word
  end

  
end

#a = Board.new

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

  puts correct_format?("3324")