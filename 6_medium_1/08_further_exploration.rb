class Card
  RANK_ORDER = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
  SUIT_ORDER = ['Diamonds', 'Clubs', 'Hearts', 'Spades']

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    if rank == other_card.rank # Same ranks, different suits
      SUIT_ORDER.index(suit) <=> SUIT_ORDER.index(other_card.suit)
    else # Different ranks
      RANK_ORDER.index(rank) <=> RANK_ORDER.index(other_card.rank)
    end
  end

  def ==(other_card)
    rank == other_card.rank && suit == other_card.suit
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

cards = [Card.new(4, 'Spades'),
         Card.new(4, 'Hearts'),
         Card.new(4, 'Clubs'),
         Card.new(4, 'Diamonds')]

p cards.min # => The 4 of Diamonds card obj
p cards.max # => The 4 of Spades card obj

# LSBot's Refractoring of #<=>
class Card
  # Omitted code
  def <=>(other_card)
    rank_comparison = RANK_ORDER.index(rank) <=> RANK_ORDER.index(other_card.rank)
    return rank_comparison unless rank_comparison.zero?
    SUIT_ORDER.index(suit) <=> SUIT_ORDER.index(other_card.suit)
  end
end

# #<=> can be refractored even further
class Card
  # Omitted code
  def <=>(other_card)
    [RANK_ORDER.index(rank), SUIT_ORDER.index(suit)] <=>
      [RANK_ODER.index(other_card.rank), SUIT_ORDER.index(other_card.suit)]
  end
end

=begin
NOTES
The refracotring takes advantage of the Ruby behaviour that when two arrays are
compared with <=>, Ruby first compares the first elements from the two arrays
and only moves on to the second elements if the first two elements are
different.
=end
