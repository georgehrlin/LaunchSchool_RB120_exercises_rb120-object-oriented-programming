=begin
FURTHER EXPLORATION
Q: How would you modify our original solution to choose the best 5-card hand
from a 7-card poker hand?
=end

=begin
A: The alogirhtm is something like
1. There are 21 (nCr(7, 5)) possible different hands given 7 different cards
   - Use Array#combination
   - The method doesn't have to stick to only accepting 7 cards, though the
     more cards it accepts the longer it'll take to process
2. Find the hand rank of all 21 hands (possibly stop this if a royal flush is
   found)
3. Find the hand that is best according to HANDS_ORDER and return it
=end

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
  include Comparable

  NUM_CARDS_PER_HAND = 5
  HANDS_ORDER = { 'High card'       => 0,
                  'Pair'            => 1,
                  'Two pair'        => 2,
                  'Three of a kind' => 3,
                  'Straight'        => 4,
                  'Flush'           => 5,
                  'Full house'      => 6,
                  'Four of a kind'  => 7,
                  'Straight flush'  => 8,
                  'Royal flush'     => 9 }

  def initialize(cards)
    @cards = []
    @rank_count = Hash.new(0)

    if cards.respond_to?(:draw)
      5.times do
        card = cards.draw
        @cards << card
        @rank_count[card.rank] += 1
      end
    else
      cards.each do |card|
        @cards << card
        @rank_count[card.rank] += 1
      end
    end
  end

  def self.best_hand(cards)
    hands = []
    cards.combination(NUM_CARDS_PER_HAND) do |combination|
      hands << PokerHand.new(combination)
    end
    hands.max_by(&:hand_rank)
    # NOTES: This is syntactic sugar for
    # hands.max_by { |h| h.public_send(:hand_rank) } (or a similar internal
    # mechanism). When &:hand_rank is evaluated, Ruby creates a generic Proc
    # object. This Proc object does not retain the special "private club"
    # access rights of the PokerHand class where it was created. The
    # symbol-to-proc creates a generic Proc that is executed from an external
    # scope, so it only gets public access.
  end

  def print
    puts @cards
  end

  def <=>(other)
    hand_rank <=> other.hand_rank
  end

  def evaluate
    if    royal_flush?     then 'Royal flush'
    elsif straight_flush?  then 'Straight flush'
    elsif four_of_a_kind?  then 'Four of a kind'
    elsif full_house?      then 'Full house'
    elsif flush?           then 'Flush'
    elsif straight?        then 'Straight'
    elsif three_of_a_kind? then 'Three of a kind'
    elsif two_pair?        then 'Two pair'
    elsif pair?            then 'Pair'
    else 'High card'
    end
  end

  # protected

  def hand_rank
    HANDS_ORDER[evaluate]
  end

  private

  def flush?
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit }
  end

  def straight?
    return false if @rank_count.any? { |_, count| count > 1 }

    @cards.min.value == @cards.max.value - 4
  end

  def n_of_a_kind?(number)
    @rank_count.one? { |_, count| count == number }
  end

  def straight_flush?
    flush? && straight?
  end

  def royal_flush?
    straight_flush? && @cards.min.rank == 10
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    @rank_count.select { |_, count| count == 2 }.size == 2
  end

  def pair?
    n_of_a_kind?(2)
  end
end

p PokerHand.best_hand([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts'),
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs')
])

p PokerHand.best_hand([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts'),
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs')
]).evaluate # => "Royal flush"
