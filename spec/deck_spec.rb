require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  context '#new' do
    it 'starts with 52 cards' do
      expect(deck.cards.count).to eq(52)
    end
  end

  context '#draw_cards' do
    let(:card) do
      card = [Card.new(:clubs, :deuce),
        Card.new(:clubs, :king)]
    end

    it 'returns 1 card by default' do
      deck.cards = card.dup
      expect(deck.draw_cards).to eq(card[0..0])
      expect(deck.draw_cards).to eq(card[1..1])
    end

    it 'removes the drawn card from the deck' do
      deck.cards = card.dup
      deck.draw_cards(2)
      expect(deck.cards.count). to eq(0)
    end

    it 'cannot take more cards than available' do
      deck.cards = card.dup
      expect{  deck.draw_cards(3)}.to raise_error
    end
  end

  context '#return_cards' do
    let(:card) do
      card = [Card.new(:clubs, :deuce),
        Card.new(:clubs, :king)]
    end

    it 'returns the card to the deck' do
      deck.cards = []
      deck.return_cards(card)
      expect(deck.cards.count).to eq(2)
    end
  end

  context '#shuffle' do
    it 'shuffles' do
      old_deck = deck.cards.dup
      deck.shuffle
      expect(deck.cards).not_to eq(old_deck)
    end
  end
end
