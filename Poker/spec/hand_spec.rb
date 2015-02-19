require 'hand'

describe Hand do

  let(:deck){ double "Deck"}
  subject(:hand){ Hand.new(deck) }
  let(:deck_cards) do
    deck_cards =  [Card.new(:spades, :deuce),
    Card.new(:diamonds, :three), Card.new(:clubs, :deuce),
    Card.new(:hearts, :three), Card.new(:diamonds, :deuce)]
  end

  context '#new' do
    it 'starts with five cards' do
      expect(deck).to receive(:draw_cards).with(5).and_return(deck_cards)
      hand = Hand.new(deck)
      expect(hand.cards).to eq(deck_cards)
    end
  end

  context '#scoring' do
    it 'finds four of a kind' do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      expect(hand.four_of_a_kind?).to eq(true)
    end

    it 'finds three of a kind' do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      expect(hand.three_of_a_kind?).to eq(true)
    end

    it 'finds pairs' do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :five),
        Card.new(:spades, :three),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      expect(hand.two_of_a_kind?).to eq(true)
    end

    it 'finds 2 pairs' do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :five),
        Card.new(:spades, :five),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      expect(hand.two_pairs?).to eq(true)
    end

    it 'finds straights' do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :six),
        Card.new(:spades, :five),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      expect(hand.straight?).to eq(true)
    end

    it 'finds straights with low ace' do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :ace),
        Card.new(:spades, :five),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      expect(hand.straight?).to eq(true)
    end

    it 'finds flushes' do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :six),
        Card.new(:spades, :five),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      expect(hand.flush?).to eq(true)
    end

    it 'finds full houses' do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :four),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      expect(hand.full_house?).to eq(true)
    end

    it 'finds straight flushes' do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :six),
        Card.new(:spades, :five),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      expect(hand.straight_flush?).to eq(true)
    end
  end

  context '#beats?' do
    it 'three of a kind beats a pair' do
      cards = [
        Card.new(:spades, :three),
        Card.new(:spades, :three),
        Card.new(:spades, :three),
        Card.new(:hearts, :five),
        Card.new(:spades, :four),
      ]
      pair =
      [
        Card.new(:spades, :three),
        Card.new(:hearts, :three),
        Card.new(:spades, :six),
        Card.new(:spades, :five),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      other_hand = Hand.new(deck)
      other_hand.cards = pair
      expect(hand.beats?(other_hand)).to eq(true)
    end

    it 'it find high cards in tes with bad hand' do
      cards = [
        Card.new(:spades, :three),
        Card.new(:spades, :ace),
        Card.new(:spades, :queen),
        Card.new(:hearts, :five),
        Card.new(:spades, :four),
      ]
      pair =
      [
        Card.new(:spades, :three),
        Card.new(:hearts, :king),
        Card.new(:spades, :six),
        Card.new(:spades, :five),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      other_hand = Hand.new(deck)
      other_hand.cards = pair
      expect(hand.beats?(other_hand)).to eq(true)
    end

    it 'it find high cards in ties with pairs of different values' do
      cards = [
        Card.new(:spades, :three),
        Card.new(:spades, :ace),
        Card.new(:spades, :ace),
        Card.new(:hearts, :five),
        Card.new(:spades, :four),
      ]
      pair =
      [
        Card.new(:spades, :three),
        Card.new(:hearts, :king),
        Card.new(:spades, :king),
        Card.new(:spades, :five),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      other_hand = Hand.new(deck)
      other_hand.cards = pair
      expect(hand.beats?(other_hand)).to eq(true)
    end

    it 'it find high cards in ties with pairs of same values' do
      cards = [
        Card.new(:spades, :king),
        Card.new(:spades, :ace),
        Card.new(:spades, :ace),
        Card.new(:hearts, :five),
        Card.new(:spades, :four),
      ]
      pair =
      [
        Card.new(:spades, :three),
        Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:spades, :king),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      other_hand = Hand.new(deck)
      other_hand.cards = pair
      expect(hand.beats?(other_hand)).to eq(true)
    end

    it 'it find high cards in ties with three of a kinds' do
      cards = [
        Card.new(:spades, :king),
        Card.new(:spades, :king),
        Card.new(:spades, :king),
        Card.new(:hearts, :five),
        Card.new(:spades, :four),
      ]
      pair =
      [
        Card.new(:spades, :ace),
        Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:spades, :king),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      other_hand = Hand.new(deck)
      other_hand.cards = pair
      expect(hand.beats?(other_hand)).to eq(false)
    end

    it 'it find high cards in ties with four of a kinds' do
      cards = [
        Card.new(:spades, :king),
        Card.new(:spades, :king),
        Card.new(:spades, :king),
        Card.new(:hearts, :king),
        Card.new(:spades, :four),
      ]
      pair =
      [
        Card.new(:spades, :ace),
        Card.new(:hearts, :ace),
        Card.new(:spades, :ace),
        Card.new(:spades, :ace),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      other_hand = Hand.new(deck)
      other_hand.cards = pair
      expect(hand.beats?(other_hand)).to eq(false)
    end

    it 'it find high cards in ties with straight' do
      cards = [
        Card.new(:spades, :king),
        Card.new(:spades, :queen),
        Card.new(:spades, :ace),
        Card.new(:spades, :ten),
        Card.new(:spades, :jack),
      ]
      pair =
      [
        Card.new(:spades, :six),
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :five),
        Card.new(:spades, :four),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      other_hand = Hand.new(deck)
      other_hand.cards = pair
      expect(hand.beats?(other_hand)).to eq(true)
    end

    it 'it find high cards in ties with two pairs' do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :five),
        Card.new(:spades, :five),
        Card.new(:spades, :three),
      ]
      pair = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :three),
        Card.new(:spades, :six),
      ]
      allow(deck).to receive(:draw_cards).and_return(cards)
      other_hand = Hand.new(deck)
      other_hand.cards = pair
      expect(hand.beats?(other_hand)).to eq(true)
    end
  end
end
