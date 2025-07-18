# Implement suggestions from LSBot
class Shelter
  attr_reader :adopted_pets, :unadopted_pets

  def initialize
    @adopted_pets = {}
    @unadopted_pets = []
  end

  def keep(pet)
    unadopted_pets << pet
  end

  def adopt(owner, pet)
    @unadopted_pets.delete(pet) if @unadopted_pets.include?(pet)
    owner.number_of_pets += 1

    if !@adopted_pets.key?(owner)
      @adopted_pets[owner] = [pet]
    else
      @adopted_pets[owner] << pet
    end
  end

  def print_unadopted
    puts "The Animal Shelter has the following unadopted pets:"
    @unadopted_pets.each do |pet|
      puts pet
    end
    puts
  end

  def print_adoptions
    @adopted_pets.each_key do |owner|
      puts "#{owner.name} has adopted the following pets:"
      @adopted_pets[owner].each do |pet|
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
chatterbox = Pet.new('parakeet', 'Chatterbox')
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

shelter.print_unadopted
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal shelter has " \
      "#{shelter.unadopted_pets.size} unadopted pets."
