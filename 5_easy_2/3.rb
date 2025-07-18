class House
  include Comparable
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# Expected output:
# >> Home 1 is cheaper
# >> Home 2 is more expensive

=begin
FURTHER EXPLORATION

Q: Is the technique we employ here to make House objects comparable a good one?
(Hint: is there a natural way to compare Houses? Is price the only criteria you
might use?) What problems might you run into, if any?

A: Conceptually I find calling a comparison operator directly on a House object
somewhat awkward. After all, what we are really comparing is a shared aspect of
two House objects, not the two houses directly. This is even shown in the
implementation detail of House#<=>. I find it more natural to access a specific
aspect of two houses, and then compare them. After all, there are other aspects
of a house that are up for comparison.

A problem with defining a House#<=> that exclusively compares prices is that it
is confined to comparing prices, ignoring the other potential comparison needs.
=end

=begin
Q: Can you think of any sort of classes where including Comparable is a good
idea?

A: There are classes of objects a primary nature of which is for comparison.
This is why many built-in classes like Integer and String have `#<=>` built
into them, although the logic for comparison may be different in each case.
=end
