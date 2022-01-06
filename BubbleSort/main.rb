def bubble_sort(array)
    n = array.length
    loop do 
      swapped = false
      (n-1).times do |i|
        if array[i] > array[i + 1]
          array[i], array[i + 1] = array[i + 1], array[i]
          swapped = true
        end
      end
    break if not swapped
    end
    array
  end
  
  arr = [777,420,3,69,3.3,0,1,-666]
  
  puts "Our array to be sorted is:   #{arr} "
  puts "Sorted:                      #{bubble_sort(arr)}"