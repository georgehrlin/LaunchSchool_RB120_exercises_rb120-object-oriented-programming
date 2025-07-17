class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, colour)
    super(name, age)
    @colour = colour
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@colour} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# Expected output:
# >> My cat Pudding is 7 years old and has black and white fur.
# >> My cat Butterscotch is 10 years old and has tan and white fur.

=begin
FURTHER EXPLORATION

Q: An alternative approach to this problem would be to modify the Pet class to
accept a colors parameter. If we did this, we wouldn't need to supply an
initialize method for Cat.

Why would we be able to omit the initialize method? Would it be a good idea to
modify Pet in this way? Why or why not? How might you deal with some of the
problems, if any, that might arise from modifying Pet?

A: We'd be able to omit the initialize method in the Cat class because we won't
need this new overriding initialize method to accept and store the third
argument. For this scenario, where we are storing and workgin with data about
pets, it is a good idea because most pets have a fur or skin colour attribute,
and a 'colour' attribute covers all possibilities well. A potential problem may
be that the inidividuals of a certain kind of pet all contain the same exterior
colour, which negates the need to store the information of that attribute. In
that case, I can define the overriding initialize method in the new class to
not accept a colour argument.
=end
