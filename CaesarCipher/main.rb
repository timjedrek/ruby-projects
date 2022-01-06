def translate(phrase, key)
    split_phrase = phrase.split("")
    convert_to = split_phrase.map do |x| 
      x.ord
    end
    add_key = convert_to.map do |y|
      if y.between?(65, 90) || y.between?(97, 122)
        if (y + key > 90 && y + key < 97) || (y + key > 122)
          while (y + key - 26).between?(90, 97) || (y + key - 26) > 122
            key -= 26
          end
          (key <= 0)?(y=y):(y + key - 26)
        else
          y + key
        end
      else
        y = y
      end
    end
    
    go_to_string = add_key.map do |z|
  
      z.chr
    end
    combine_it = go_to_string.join('')
    puts "Your new phrase is: #{combine_it}"
  end
  
  puts 'Enter a phrase'
  phrase = gets.chomp
  puts 'Enter a key'
  key = gets.chomp.to_i
  print 'You have inputed "'
  print phrase
  print '" with a key of "'
  print key
  puts '"'
  puts 'Commence the Caesar Cipher!'
  
  translate(phrase, key)