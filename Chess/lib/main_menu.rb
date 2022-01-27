# functions to draw welcome screen
module MainMenu
  
  def main_menu
    welcome_graphic
    display_menu
    input = gets.chomp
    menu_selection(input)
  end
  
  def welcome_graphic
    art = '''
    ▄████▄   ██░ ██ ▓█████   ██████   ██████ 
    ▒██▀ ▀█  ▓██░ ██▒▓█   ▀ ▒██    ▒ ▒██    ▒ 
    ▒▓█    ▄ ▒██▀▀██░▒███   ░ ▓██▄   ░ ▓██▄   
    ▒▓▓▄ ▄██▒░▓█ ░██ ▒▓█  ▄   ▒   ██▒  ▒   ██▒
    ▒ ▓███▀ ░░▓█▒░██▓░▒████▒▒██████▒▒▒██████▒▒
    ░ ░▒ ▒  ░ ▒ ░░▒░▒░░ ▒░ ░▒ ▒▓▒ ▒ ░▒ ▒▓▒ ▒ ░
      ░  ▒    ▒ ░▒░ ░ ░ ░  ░░ ░▒  ░ ░░ ░▒  ░ ░
    ░         ░  ░░ ░   ░   ░  ░  ░  ░  ░  ░  
    ░ ░       ░  ░  ░   ░  ░      ░        ░  
    ░                                         
    '''
    puts art.red
    current_year = Time.now.year
    copyright =  "Copyright #{current_year} Tim Jedrek"
    puts copyright.red.underline
    puts ''
  end

  def display_menu
    puts 'Please choose an option'.italic
    puts '1 - Play new game'
    puts '2 - Load file'
    puts '3 - Save file'
    puts '4 - End game'
    puts '5 - Resume game'
    puts '6 - Help'
  end

  def menu_selection(input)
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
    when 6
      help
    else
      invalid_mm_selection(input)
    end
  end

  def invalid_mm_selection(input)
    puts "Try again. #{input} is not valid. Enter a number between 1-6"
    sleep(1)
    puts `clear`
    main_menu
  end
end
