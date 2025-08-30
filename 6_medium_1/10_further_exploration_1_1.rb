# Using class instance variables in PokerHand
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
  @cards = []
  @rank_count = Hash.new(0)

  def self.add_cards(cards)
    5.times do
      card = cards.draw
      @cards << card
      @rank_count[card.rank] += 1
    end
  end

  def print
    puts @cards
  end

  def self.cards
    @cards
  end

  def self.rank_count
    @rank_count
  end

  def self.evaluate
    if    self.royal_flush?     then 'Royal flush'
    elsif self.straight_flush?  then 'Straight flush'
    elsif self.four_of_a_kind?  then 'Four of a kind'
    elsif self.full_house?      then 'Full house'
    elsif self.flush?           then 'Flush'
    elsif self.straight?        then 'Straight'
    elsif self.three_of_a_kind? then 'Three of a kind'
    elsif self.two_pair?        then 'Two pair'
    elsif self.pair?            then 'Pair'
    else 'High card'
    end
  end

  private

  def self.flush?
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit }
  end

  def self.straight?
    return false if @rank_count.any? { |_, count| count > 1 }

    @cards.min.value == @cards.max.value - 4
  end

  def self.n_of_a_kind?(number)
    @rank_count.one? { |_, count| count == number }
  end

  def self.straight_flush?
    flush? && straight?
  end

  def self.royal_flush?
    straight_flush? && @cards.min.rank == 10
  end

  def self.four_of_a_kind?
    n_of_a_kind?(4)
  end

  def self.full_house?
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end

  def self.three_of_a_kind?
    n_of_a_kind?(3)
  end

  def self.two_pair?
    @rank_count.select { |_, count| count == 2 }.size == 2
  end

  def self.pair?
    n_of_a_kind?(2)
  end

  def self.reset
    @cards = []
    @rank_count = Hash.new(0)
  end
end

PokerHand.add_cards(Deck.new)
puts PokerHand.evaluate
PokerHand.reset
# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
PokerHand.add_cards([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts PokerHand.evaluate == 'Royal flush'
PokerHand.reset

PokerHand.add_cards([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts PokerHand.evaluate == 'Straight flush'
PokerHand.reset

PokerHand.add_cards([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts PokerHand.evaluate == 'Four of a kind'
PokerHand.reset

PokerHand.add_cards([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts PokerHand.evaluate == 'Full house'
PokerHand.reset

PokerHand.add_cards([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts PokerHand.evaluate == 'Flush'
PokerHand.reset

PokerHand.add_cards([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts PokerHand.evaluate == 'Straight'
PokerHand.reset

PokerHand.add_cards([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts PokerHand.evaluate == 'Straight'
PokerHand.reset

PokerHand.add_cards([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts PokerHand.evaluate == 'Three of a kind'
PokerHand.reset

PokerHand.add_cards([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts PokerHand.evaluate == 'Two pair'
PokerHand.reset

PokerHand.add_cards([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts PokerHand.evaluate == 'Pair'
PokerHand.reset

PokerHand.add_cards([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts PokerHand.evaluate == 'High card'
PokerHand.reset
