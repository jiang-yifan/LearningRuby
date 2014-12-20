require 'card'

describe Card do
  subject(:card) { Card.new(:clubs, :deuce) }

  context '#new' do
    it 'Creates new object of type Card' do
      expect(card.class).to eq(Card)
    end


    it 'Must have possible value & suit' do
      expect { card = Card.new(:blah, 14) }.to raise_error("error")
    end
  end

  it 'returns its suit' do
    expect(card.suit).to eq(:clubs)
  end

  it 'returns its value' do
    expect(card.value).to eq(:deuce)
  end
end
