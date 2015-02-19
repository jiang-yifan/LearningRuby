class Human

  attr_accessor :word_length, :guess_array, :choice, :secret_word
  def initialize
    @secret_word = nil
    @word_length = 0
    @guess_array = []
    @choice = ""
  end

  def pick_secret_word
    p "enter word length"
    self.word_length = gets.chomp.to_i
  end

  def receive_secret_length(word_length)
    @guess_array = Array.new(word_length, "_")
    p @guess_array
  end

  def guess
    p "enter a letter"
      @choice = gets.chomp
  end

  def check_guess(guess)
    p "computer guesses: #{guess} Y/N "
    confirm = gets.chomp
    if confirm == "Y"
      p "enter indexes"
      index = gets.chomp
    else
      false
    end
  end

  def handle_guess_response(response)
    p response
    self.guess_array = response

  end

end

class Computer
  attr_accessor :dictionary, :word_length, :guess_array, :alphabet_arr, :choice, :secret_word
  def initialize
    @dictionary = []
    File.open("dictionary.txt").each_line do |word|
      @dictionary << word.chomp
    end
    @guess_array = []
    @alphabet_arr = ("a".."z").to_a
    @guess = ""
    @secret_word = nil
  end

  def pick_secret_word
    self.secret_word = dictionary.sample
    self.guess_array = Array.new( secret_word.length, "_")
    self.word_length = secret_word.length

    #self.secret_word = # TODO
  end

  def receive_secret_length(length)
    self.word_length = length
    length.times do
      guess_array << "_"
    end
  end

  def guess
    self.choice = alphabet_arr.sample
  end

  def check_guess(input)
    if secret_word.include?(input)
      secret_word.chars.each.with_index do |letter, i|
        if secret_word[i].include?(input)
          p guess_array[i]
          guess_array[i] = input
          p guess_array[i]
        end
      end
    end
    guess_array
  end

  def handle_guess_response(response)
    p response
    if response
      guess_array[response.to_i] = choice
    else
      guess
    end
  end

end

class Game

  attr_accessor :guessing_player, :answer_player
  #
  # def self.get_players
  #   player_arr = []
  #   2.times do |i|
  #   p "Enter Player #{ i} Type (Human/AI): H/A"# puts
  #     choice = gets.chomp
  #     player_arr << self.transpose (choice)
  #   end
  #    p player_arr    # RETURNS ARRAY OF TWO PLAYER OBJECTS
  # end
  #
  # def self.transpose(str)
  #   case str
  #   when "H"
  #     Human.new
  #   when "A"
  #     Computer.new
  #   end
  # end

  def initialize guessing_player, answer_player
    #players = self.class.get_players.inject()

    @guessing_player, @answer_player = guessing_player , answer_player
  end

  def play
      answer_player.pick_secret_word
      p answer_player.secret_word
      guessing_player.receive_secret_length(answer_player.word_length)

      until won?
        guessing_player.guess
        # p guessing_player.choice
        response = answer_player.check_guess(guessing_player.choice)
        guessing_player.handle_guess_response(response)
        p guessing_player.guess_array
      end
  end

  def won?
    !guessing_player.guess_array.include?("_")
  end

end

human = Human.new
computer = Computer.new
game = Game.new(computer, human)

game.play
