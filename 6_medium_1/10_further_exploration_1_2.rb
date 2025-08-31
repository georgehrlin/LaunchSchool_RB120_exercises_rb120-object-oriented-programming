class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

class PokerHand
  def self.print(cards)
    puts cards
  end

  def self.evaluate(cards)
    if    royal_flush?(cards)     then 'Royal flush'
    elsif straight_flush?(cards)  then 'Straight flush'
    elsif four_of_a_kind?(cards)  then 'Four of a kind'
    elsif full_house?(cards)      then 'Full house'
    elsif flush?(cards)           then 'Flush'
    elsif straight?(cards)        then 'Straight'
    elsif three_of_a_kind?(cards) then 'Three of a kind'
    elsif two_pair?(cards)        then 'Two pair'
    elsif pair?(cards)            then 'Pair'
    else 'High card'
    end
  end

  private

  def self.flush?(cards)
    suit = cards.first.suit
    cards.all? { |card| card.suit == suit }
  end

  def self.straight?(cards)
    return false if rank_count(cards).any? { |_, count| count > 1 }

    cards.min.value == cards.max.value - 4
  end

  def self.n_of_a_kind?(number, cards)
    rank_count(cards).one? { |_, count| count == number }
  end

  def self.straight_flush?(cards)
    flush?(cards) && straight?(cards)
  end

  def self.royal_flush?(cards)
    straight_flush?(cards) && cards.min.rank == 10
  end

  def self.four_of_a_kind?(cards)
    n_of_a_kind?(4, cards)
  end

  def self.full_house?(cards)
    n_of_a_kind?(3, cards) && n_of_a_kind?(2, cards)
  end

  def self.three_of_a_kind?(cards)
    n_of_a_kind?(3, cards)
  end

  def self.two_pair?(cards)
    rank_count(cards).select { |_, count| count == 2 }.size == 2
  end

  def self.pair?(cards)
    n_of_a_kind?(2, cards)
  end

  def self.rank_count(cards)
    result = Hash.new(0)
    cards.each { |card| result[card.rank] += 1 }
    result
  end
end

PokerHand.print([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])

# Test that we can identify each PokerHand type.
puts PokerHand.evaluate([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
]) == 'Royal flush'

puts PokerHand.evaluate([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
]) == 'Straight flush'

puts PokerHand.evaluate([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
]) == 'Four of a kind'

puts PokerHand.evaluate([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
]) == 'Full house'

puts PokerHand.evaluate([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
]) == 'Flush'

puts PokerHand.evaluate([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
]) == 'Straight'

puts PokerHand.evaluate([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
]) == 'Straight'

puts PokerHand.evaluate([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
]) == 'Three of a kind'

puts PokerHand.evaluate([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
]) == 'Two pair'

puts PokerHand.evaluate([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
]) == 'Pair'

puts PokerHand.evaluate([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
]) == 'High card'
