#module InWords
class Fixnum
  def in_words

    number = self.to_s.split("")

    $size = self.to_s.length

    temporary=[]

    case (($size + 2) / 3)
    when 1
      if $size == 1
        p self.ones(number)
      elsif $size == 2
        p self.tens(number)
      else
        p self.hundreds(number)
      end
    when 2
      if $size == 4
        temporary << number.shift
      elsif $size == 5
        temporary << number.shift
        temporary << number.shift
      elsif $size == 6
        temporary << number.shift
        temporary << number.shift
        temporary << number.shift
      end
      p self.thousands(temporary) + self.hundreds(number)
    when 3
      if $size == 7
        temporary << number.shift
      elsif $size == 8
        temporary << number.shift
        temporary << number.shift
      elsif $size == 9
        temporary << number.shift
        temporary << number.shift
        temporary << number.shift
      end
      p self.millions(temporary) + self.thousands(number) + self.hundreds(number[-3..-1])
    when 4
      if $size == 10
        temporary << number.shift
      elsif $size == 11
        temporary << number.shift
        temporary << number.shift
      elsif $size == 12
        temporary << number.shift
        temporary << number.shift
        temporary << number.shift
      end
      p self.billions(temporary) + self.millions(number[-9..-7]) + self.thousands(number[-6..-4]) + self.hundreds(number[-3..-1])
    when 5
      if $size == 13
        temporary << number.shift
      elsif $size == 14
        temporary << number.shift
        temporary << number.shift
      elsif $size == 15
        temporary << number.shift
        temporary << number.shift
        temporary << number.shift
      end
      p self.trillions(temporary) +  self.billions(number[-12..-10]) + self.millions(number[-9..-7]) + self.thousands(number[-6..-4]) + self.hundreds(number[-3..-1])
    end

  end

  def ones(array)
    $hash[array[0]][0]
  end

  def tens(array)
    if array[0] == '0'
      if array[1] == '0'
        ''
      else
        self.ones(array[1])
      end
    elsif array[0] == '1'
      $hash[array[1]][2]
    else
      if array[1] == '0'
        $hash[array[0]][1]
      else
        $hash[array[0]][1] + " " + self.ones(array[1])
      end
    end
  end

  def hundreds(array)
    if array[0] == '0'
      self.tens(array[1..2])
    elsif self.to_s[-1] == '0' && self.to_s[-2] == '0' && self.to_s[-3] == '0'
      ""
    else
      if array[1] == '0' && array[2] == '0'
        $hash[array[0]][0] + " hundred"
      else
        $hash[array[0]][0] + " hundred "+ self.tens(array[1..2])
      end
    end
  end

  def thousands(array)
    if self.to_s[-4] == '0' && self.to_s[-5] == '0' && self.to_s[-6] == '0'
      ""
    elsif self.to_s[-1] == '0' && self.to_s[-2] == '0' && self.to_s[-3] == '0'
      case array.count % 3
      when 1
        self.ones(array) + " thousand"
      when 2
        self.tens(array) + " thousand"
      else
        self.hundreds(array) + " thousand"
      end
    else
      case array.count % 3
      when 1
        self.ones(array) + " thousand "
      when 2
        self.tens(array) + " thousand "
      else
        self.hundreds(array) + " thousand "
      end
    end
  end

  def millions(array)
    if self.to_s[-7] == '0' && self.to_s[-8] == '0' && self.to_s[-9] == '0'
      ""
    elsif array.count % 3 == 1
      self.ones(array) + " million "
    elsif array.count % 3 == 2
      self.tens(array) + " million "
    else
      self.hundreds(array) + " million "
    end
  end

  def billions(array)
    if self.to_s[-10] == '0' && self.to_s[-11] == '0' && self.to_s[-12] == '0'
      ""
    elsif array.count % 3 == 1
      self.ones(array) + " billion "
    elsif array.count % 3 == 2
      self.tens(array) + " billion "
    else
      self.hundreds(array) + " billion "
    end
  end

  def trillions(array)
    if self % 1000000000 == 0
      if array.count % 3 == 1
        self.ones(array) + " trillion"
      elsif array.count % 3 == 2
        self.tens(array) + " trillion"
      else
        self.hundreds(array) + " trillion"
      end
    else
      if array.count % 3 == 1
        self.ones(array) + " trillion "
      elsif array.count % 3 == 2
        self.tens(array) + " trillion "
      else
        self.hundreds(array) + " trillion "
      end
    end
  end

  $hash = {'1' => ['one', 'ten', 'eleven'], '2' => ['two', 'twenty', 'twelve'], '3' => ['three', 'thirty', 'thirteen'],
  '4' => ['four', 'forty', 'fourteen'], '5' => ['five', 'fifty', 'fifteen'], '6' => ['six', 'sixty', 'sixteen'],
  '7' => ['seven', 'seventy', 'seventeen'], '8' => ['eight', 'eighty', 'eighteen'], '9' => ['nine', 'ninety', 'nineteen'],
  '0' => ['zero', '', 'ten']}
end


#a = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
b = [ 20, 21, 22 ,23 ,24 , 25, 26, 13453,544422, 7888894, 9234838914, 589679234838914]
i = 0
while i < b.count
  b[i].in_words
  i += 1
end
