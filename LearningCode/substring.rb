def substrings string

  result = []

  string.size.times do |sublength|
    (0..string.size - sublength - 1).each do |start|
      result << string[start.. start + sublength]
    end
  end

  subwords result

end

def subwords array
  words = File.readlines('dictionary.txt').map(&:chomp)
  array.select { |word| words.include?(word) }
end


p substrings('cat')
