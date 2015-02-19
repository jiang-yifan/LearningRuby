require_relative 'deck.rb'
require_relative 'player.rb'

class Game
  attr_accessor :deck, :players_arr, :turn
  def initialize(names= ["Bob", "Mark", "Sally"], pot = 2000)
    @deck = Deck.new
    @players_arr = []
    names.each do |name|
      @players_arr << Player.new name, pot
    end
    @turn = 0
  end

  def play
    blind_player = 0

    players_arr.each do |player|
      player.new_hand(deck)
    end
    #players bet
    players_arr#- the folded.discard
    #players redraw
    # players bet again
    #winner determined
    #then reloop

    #break loop when poor
  end

end
