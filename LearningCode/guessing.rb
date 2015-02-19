def guessing
  guesses = 0
  number = 1 + rand(100)

  userinput = 0

  until userinput == number
    puts "please guess a number"
    userinput = gets.chomp.to_i

    if userinput > number
      puts "you've guessed too high"
    elsif userinput < number
      puts "you've guessed too low"
    end

    guesses += 1
  end

  puts "you guessed correct in #{ guesses } guesses"

end

guessing
