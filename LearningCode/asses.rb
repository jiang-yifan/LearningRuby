def is_prime?(num)
  (2..Math.sqrt(num).to_i).none? do |factor|
    num % factor == 0
  end
end

def primes(count)
  primes = []
  i = 0
  until primes.count == count
    primes << is_prime?(i)
    i += 1
  end
end

# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
def factorials_rec(num)
  return [1] if num == 1

  facs = factorial_rec(num - 1)
  facs << facs.last * num
end

class Array
  def dups
    occurance = Hash.new {|h,k| h[k] = []}
    self.each_with_index do |num, index|
      occurance[number] << index
    end
    occurance.select {|k,v| v.size > 1} || []
  end
end

class String

  def symmetric_substrings
    results =[]
    length.times do |start|
      (start...length).to_a.each do |tail|
        results << self[start..tail] if palindrome? (self[self..tail])
      end
    end
  end

  def palindrome? str
    str.reverse == str
  end
end

class Array
  def merge_sort(&prc)
    middle = count/2
    merge(self.take(middle), self.drop(middle), &prc)
  end

  def merge(left, right, &prc)
    results = []

    until left.empty? || right.empty?
        if prc.call(left.first, right.first) == 1
          results << left.shift
        else
          results << right.shift
        end
    end
    results + left + right
  end
end
