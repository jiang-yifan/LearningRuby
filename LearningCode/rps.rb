def rps(choice)
  array = ['rock', 'paper', 'scissors']
  victory = {
    'rock' => 'scissors',
    'paper' => 'rock',
    'scissors' => 'paper'
  }
  ai_choice = array.sample
  puts "AI CHOOSES #{ai_choice}"
  if victory[choice] == ai_choice
    puts "you win! #{choice} beats #{ai_choice}!"
  elsif choice == ai_choice
    puts "tie"
  else
    puts "you lose! #{ai_choice} beats #{choice}!"
  end
  # ai = rand(3)
  # case ai
  # when 0
  #   if choice == 0
  #     puts "#{ array [ai] } tie"
  #   elsif choice == 1
  #     puts "#{  array [ai] } win"
  #   else
  #     puts "#{  array [ai] } lose"
  #   end
  # when 1
  #   if choice == 0
  #     puts "#{  array [ai] } lose"
  #   elsif choice == 1
  #     puts "#{  array [ai] } tie"
  #   else
  #     puts "#{  array [ai] } win"
  #   end
  # when 2
  #   if choice == 0
  #     puts "#{  array [ai] } win"
  #   elsif choice == 1
  #     puts "#{  array [ai] } lose"
  #   else
  #     puts "#{  array [ai] } tie"
  #   end
  # end
end

rps('rock')
