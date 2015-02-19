require_relative 'card.rb'
class Hand
  SCORING_HASH = {
    :straight_flush => 10,
    :four_of_a_kind => 9,
    :full_house => 8,
    :flush => 7,
    :straight => 6,
    :three_of_a_kind => 5,
    :two_pairs => 4,
    :pair => 3
  }
  attr_accessor :cards

  def initialize(deck)
    @cards =deck.draw_cards(5)
  end

  def beats? other_hand
    if score != other_hand.score
      score > other_hand.score
    elsif poker_sort.join.to_i != other_hand.poker_sort.join.to_i
      poker_sort.join.to_i > other_hand.poker_sort.join.to_i
    else
      return 'Tie'
    end
  end

  def score
    return 10 if straight_flush?
    return 9 if four_of_a_kind?
    return 8 if full_house?
    return 7 if flush?
    return 6 if straight?
    return 5 if three_of_a_kind?
    return 4 if two_pairs?
    return 3 if two_of_a_kind?
    1
  end

  def four_of_a_kind?
    create_count_hash.values.any? { |value| value >= 4 }
  end

  def three_of_a_kind?
    create_count_hash.values.any? { |value| value == 3 }
  end

  def two_of_a_kind?
    create_count_hash.values.any? { |value| value == 2 }
  end

  def two_pairs?
    create_count_hash.values.select{ |value| value == 2 }.count == 2
  end

  def straight?
    translated_values = []
    cards.each do |card|
      translated_values << Card::POKER_VALUE[card.value]
    end
    translated_values.sort!
    if translated_values.first == 2 && translated_values.last == 14
      translated_values.pop
      translated_values.unshift(1)
    end
    4.times do |i|
      return false unless translated_values[i] == translated_values[i + 1] - 1
    end
    true
  end

  def flush?
    count_hash = Hash.new(0)
    cards.each do |card|
      count_hash[card.suit] += 1
    end
    count_hash.values.any? { |value| value >= 5 }
  end

  def full_house?
    three_of_a_kind? && two_of_a_kind?
  end

  def straight_flush?
    flush?  && straight?
  end

  def create_count_hash
    count_hash = Hash.new(0)
    cards.each do |card|
      count_hash[card.value] += 1
    end
    count_hash
  end

  def poker_sort
    count_hash = create_count_hash
    sorted = false
    until sorted
      sorted = true
      (0...cards.count-1).each do |i|
        if count_hash[cards[i].value] > count_hash[cards[i+1].value]

        elsif count_hash[cards[i].value] < count_hash[cards[i+1].value]
          self.cards[i], self.cards[i+1] = cards[i+1], cards[i]
          sorted = false
        else
          case Card::POKER_VALUE[cards[i].value] <=> Card::POKER_VALUE[cards[i+1].value]
          when -1
            self.cards[i], self.cards[i+1] = cards[i+1], cards[i]
            sorted = false
          end
        end
      end
    end
    card_values = cards.map { |card| Card::POKER_VALUE[card.value] }
  end
end
