class Animal
  attr_reader :colour

  def initialize(colour)
    @colour = colour
    puts "Found in Animal Class"
  end
end

class Cat < Animal
  def colour
    puts super
    puts "Checked in Cat class / "
    puts super
  end
end

cat1 = Cat.new('Black')
cat1.colour
# >> Found in Animal Class
# >> Black
# >> Checked in Cat class /
# >> Black
