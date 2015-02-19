def shuffle
  lines = []

  puts "please enter filename to be opened"
  name = gets.chomp

  lines = File.readlines("#{ name }.txt").shuffle

  f = File.new("#{ name }--shuffled.txt", 'w')
  lines.each { |line| f.puts line }
  f.close
end

shuffle
