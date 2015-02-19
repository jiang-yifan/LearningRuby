class Array
  def my_uniq
    self.uniq
  end

  def two_sum
    answer = []
    (self.count - 1).times do |i|
      (i + 1...self.count).each do |j|
        answer << [i, j] if self[i] + self[j] == 0
      end
    end

    answer
  end
end
