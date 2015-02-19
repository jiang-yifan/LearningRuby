def bubble_sort(array)
  sorted = false
  until sorted
    sorted = true
    (0...array.size-1).each do |i|

      if array[i] > array[i+1]
        array[i+1] , array[i] = array[i], array[i+1]
        sorted = false
      end
    end
  end

  array
end


p bubble_sort([4,3,5,2,1,6])
