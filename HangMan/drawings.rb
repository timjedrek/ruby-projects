module Drawings

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

  def position_11
    puts '''
      =======================
            +-------+
            |       |
            |       O
            |     - + -
            |   /   |   \
            |       +
            |      / \
            |     |   |
            |
      =======================
      '''
    end
  
  def position_10
    puts '''
      =======================
            +-------+
            |       |
            |       O
            |     - + -
            |   /   |   \
            |       +
            |      /
            |     |
            |
      =======================
      '''
  end
  
  def position_9
    puts '''
      =======================
            +-------+
            |       |
            |       O
            |     - + -
            |   /   |   \
            |       +
            |      
            |     
            |
      =======================
      '''
  end
  
  def position_8
    puts '''
      =======================
            +-------+
            |       |
            |       O
            |     - + -
            |   /   |   \
            |       
            |      
            |     
            |
      =======================
      '''
  end
  
  
  
  def position_7
    puts '''
      =======================
            +-------+
            |       |
            |       O
            |     - + -
            |   /       \
            |       
            |      
            |     
            |
      =======================
      '''
  end
  
  def position_6
    puts '''
      =======================
            +-------+
            |       |
            |       O
            |     - + -
            |   /       
            |       
            |      
            |     
            |
      =======================
      '''
  end
  
  def position_5
    puts '''
      =======================
            +-------+
            |       |
            |       O
            |     - +
            |   /       
            |       
            |      
            |     
            |
      =======================
      '''
  end
  
  
  def position_4
    puts '''
      =======================
            +-------+
            |       |
            |       O
            |     - + 
            |         
            |       
            |      
            |     
            |
      =======================
      '''
  end
  
  def position_3
    puts '''
      =======================
            +-------+
            |       |
            |       O
            |       + 
            |          
            |       
            |      
            |     
            |
      =======================
      '''
  end
  
  def position_2
    puts '''
      =======================
            +-------+
            |       |
            |       0
            |       
            |          
            |       
            |      
            |     
            |
      =======================
      '''
  end
  
  def position_1
    puts '''
      =======================
            +-------+
            |       |
            |       
            |       
            |          
            |       
            |      
            |     
            |
      =======================
      '''
  end
  

  
end
  
module Welcome
  def welcome
    hang_man_art = '''
     __ __                 __  ___        
    / // /__ ____  ___ _  /  |/  /__ ____ 
   / _  / _ `/ _ \/ _ `/ / /|_/ / _ `/ _ \
  /_//_/\_,_/_//_/\_, / /_/  /_/\_,_/_//_/
                 /___/                    
  '''
    puts hang_man_art.cyan.bold
    current_year = Time.now.year
    copyright =  "Copyright #{current_year} Tim Jedrek"
    puts copyright.cyan.underline
    puts ""
  end
end