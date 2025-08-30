require 'pry-byebug'

class Card
  RANK_ORDER = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    RANK_ORDER.index(rank) <=> RANK_ORDER.index(other_card.rank)
  end

  def ==(other_card)
    rank == other_card.rank && suit == other_card.suit
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = generate_new_deck
    @cards.shuffle!
  end

  def generate_new_deck
    new_deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        new_deck << Card.new(rank, suit)
      end
    end
    new_deck
  end

  # Unneccessary, Array#shuffle! already exists
  def shuffle!
    self.each do |card|
      self.insert(rand(0...self.size), self.delete(card))
    end
  end

  def draw
    card_drawn = @cards.shift
    @cards = generate_new_deck.shuffle! if @cards.empty?
    card_drawn
  end
end

deck = Deck.new
drawn = []
#binding.pry
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
