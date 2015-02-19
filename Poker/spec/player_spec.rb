require 'player'

describe Player do
  subject(:player) { Player.new("playa", 500) }

  let(:deck){ double "Deck"}
  let(:cards) do
    cards = [
      Card.new(:spades, :deuce),
      Card.new(:spades, :deuce),
      Card.new(:spades, :deuce),
      Card.new(:spades, :deuce),
      Card.new(:spades, :four),
    ]
  end



  context '#new_hand' do

    it 'creates a hand of five cards' do
      allow(deck).to receive(:draw_cards).and_return(cards)
      player.new_hand(deck)
      expect(player.hand.cards.count).to eq(5)
    end

  end

  context '#discard' do

    it 'removes specified cards from hand' do
      allow(deck).to receive(:draw_cards).and_return(cards.dup)
      allow(deck).to receive(:return_cards)
      player.new_hand(deck)
      player.discard([0], deck)
      expect(player.hand.cards).to eq(cards[1..-1])
    end
  end

  context '#bet' do

    it 'reduces pot by the amount of the bet' do
      player.bet(200)
      expect(player.pot).to eq(300)
    end
  end


end
