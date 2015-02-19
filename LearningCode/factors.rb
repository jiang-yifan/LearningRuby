def factors(num)
  (1..num).to_a.select { |factor| (num % factor).zero? }
end

p factors( 140)
