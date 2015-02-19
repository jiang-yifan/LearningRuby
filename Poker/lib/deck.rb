require_relative 'card'

class Deck
  attr_accessor :cards
  def initialize
    @cards = create_deck
  end

  def create_deck
    deck = []
    Card::SUIT_STRINGS.keys.each do |suit|
      Card::VALUE_STRINGS.keys.each do |value|
        deck << Card.new(suit, value)
      end
    end

    deck
  end

  def draw_cards(n = 1)
    raise "error" unless cards.count >= n
    cards.shift(n)
  end

  def return_cards(returned_cards)
    returned_cards.each do |card|
      cards << card
    end
  end

  def shuffle
    cards.shuffle!
  end
end
