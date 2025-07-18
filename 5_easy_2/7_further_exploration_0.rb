=begin
FURTHER EXPLORATION

Add your own name and pets to this project.

Suppose the shelter has a number of not-yet-adopted pets, and wants to manage
them through this same system. Thus, you should be able to add the following
output to the example output shown above:

The Animal Shelter has the following unadopted pets:
a dog named Asta
a dog named Laddie
a cat named Fluffy
a cat named Kat
a cat named Ben
a parakeet named Chatterbox
a parakeet named Bluebell
   ...

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
The Animal shelter has 7 unadopted pets.

Can you make these updates to your solution? Did you need to change your class
system at all? Were you able to make all of your changes without modifying the
existing interface?
=end

# For this Further Exploration I will use my own original solution instead of
# the Official Solution

class Shelter
  attr_reader :owners_n_pets, :unadopted_pets

  def initialize
    @owners_n_pets = {}
    @unadopted_pets = []
  end

  def keep(pet)
    unadopted_pets << pet
  end

  def adopt(owner, pet)
    owner.number_of_pets += 1

    if !@owners_n_pets.key?(owner)
      @owners_n_pets[owner] = [pet]
    else
      @owners_n_pets[owner] << pet
    end
  end

  def print_adoptions
    puts "The Animal Shelter has the following unadopted pets:"
    @unadopted_pets.each do |pet|
      puts pet
    end
    puts

    @owners_n_pets.each_key do |owner|
      puts "#{owner.name} has adopted the following pets:"
      @owners_n_pets[owner].each do |pet|
        puts pet
      end
      puts
    end
  end
end

class Owner
  attr_reader :name
  attr_accessor :number_of_pets

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end
end

class Pet
  attr_reader :animal, :name

  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{animal} named #{name}"
  end
end

# Adopted pets
butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

# Unadopted pets
asta       = Pet.new('dog', 'Asta')
laddie     = Pet.new('dog', 'Laddie')
fluffy     = Pet.new('cat', 'Fluffy')
kat        = Pet.new('cat', 'Kat')
ben        = Pet.new('cat', 'Ben')
chatterbox = Pet.new('Parakeet', 'Chatterbox')
bluebell   = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.keep(asta)
shelter.keep(laddie)
shelter.keep(fluffy)
shelter.keep(kat)
shelter.keep(ben)
shelter.keep(chatterbox)
shelter.keep(bluebell)

shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal shelter has " \
      "#{shelter.unadopted_pets.size} unadopted pets."

=begin
Q: Can you make these updates to your solution? Did you need to change your
class system at all? Were you able to make all of your changes without
modifying the existing interface?

A: I made the necessary updates. I didn't need to change my class system. I
ended up modifying the interface: I added the instance method keep and the
getter method unadopted_pets to the interface of Shelter.
=end
