class Game
  attr_reader :ai
  def initialize
    @ai = Ai.new
    @ai.choose_peg
  end

  def play
    10.times do |i|
      ai.call_input
      puts "ai choses: #{ ai.chosen_peg }"
      ai.deal_with_input
      if ai.won?
        puts "you have won in #{ i + 1 } guesses"
        break
      else
        puts "you have made #{ ai.count_exact} exact matches"
        puts "you have made #{ ai.count_near_match} near matches"
        puts "#{ 10 - i } guesses remaining."
      end
    end
  end
end

class User
  attr_accessor :choices

  def input
    puts "Please enter your guess in RGBY format:"
    self.choices = gets.chomp.upcase.split('')
  end

  def check_input (argument)
     unless argument.count == 4
       raise "You must enter four arguments"
       input
     end


  end

end

class Ai
  attr_accessor :master_pegs, :chosen_peg,
                :count_exact, :count_near_match,
                :user

  def initialize
    @master_pegs = [ 'R', 'G', 'B', 'Y', 'O', 'P']
    @chosen_peg = []
    @count_exact = 0
    @count_near_match = 0
    @user = User.new
  end

  def choose_peg
    self.chosen_peg = master_pegs.sample(4)
  end

  def deal_with_input
    self.count_exact = 0
    self.count_near_match = 0
    user.choices.each.with_index do |choice, index|
       if chosen_peg[index] == choice
         self.count_exact += 1
       elsif chosen_peg.include? choice
         self.count_near_match += 1
       end
    end
  end

  def won?
    count_exact == 4
  end

  def call_input
    user.input
  end
end

game = Game.new
game.play
