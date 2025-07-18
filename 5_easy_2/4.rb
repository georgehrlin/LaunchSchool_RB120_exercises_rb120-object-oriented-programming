class Transform
  def self.lowercase(input)
    puts @data
    input.downcase
  end

  def initialize(input)
    @data = input
  end

  def uppercase
    @data.upcase
  end
end

# Provided code
my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

# Expected output
# >> ABC
# >> xyz

=begin
FURTHER EXPLORATION

Q: A class method is also, somewhat confusingly, called a "singleton method"
(the term is used in other contexts as well). We don't recommend learning the
details at this time - it may be more confusing than it is helpful - but you
should be aware that you may encounter this term.

A: Cool. Noted. I asked Grok 4 to provide me a barebone explanation of what a
singleton method is. It told me that a singleton method is a method that is
"added to a single, specific object (rather than shared across all instances of
a class)". A class method is a singleton method because any class is an
instance of the Class class.
=end
