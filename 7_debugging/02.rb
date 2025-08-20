=begin
Without running the faulty code, I believe line 2 raises an error regarding a
wrong number of arguments being passed to initialize.
This is because line 50 passes three arguments to SongBird's initialize. While
SongBird#initialize takes three arguments, it also calls super without
specifying arguments which by default passes all three arguments that were
passed to SongBird#initialize to Animal#initialize. An error is then raises
because Animal#initialize only accepts two arguments.
=end

=begin
ADDENDUM
Line 2 of the faulty code raises an ArgumentError.
=end

# My fix:
class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super(diet, superpower)
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

=begin
FURTHER EXPLORATION
Q: Is the FlightlessBird#initialize method necessary? Why or why not?

A: No, because FlightlessBird already inherits Animal#initialize, so
   there is no need to create FlightlessBird#initialize when all it contains is
   a super without any modification.
=end
