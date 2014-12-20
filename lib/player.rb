require 'hand'

class Player
  attr_accessor :name, :pot, :hand, :folded
  def initialize(name, pot)
    @name, @pot = name, pot
    @hand = []
    @folded = false
  end

  def new_hand(deck)
    @hand = Hand.new(deck)
  end

  def discard(selected_cards, deck)
    returning_cards = []
    selected_cards.each do |card_i|
      returning_cards << hand.cards[card_i]
      hand.cards[card_i] = nil
    end
    hand.cards.compact!
    #draw_cards(selected_cards.count, deck)
    deck.return_cards(returning_cards)
  end

  def draw_cards count, deck
    deck.draw_cards(count).each do |card|
      hand.cards << card
    end
  end

  def bet(amt)
    self.pot -= amt
  end

end
