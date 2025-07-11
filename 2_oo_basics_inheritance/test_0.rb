class Animal
  attr_reader :colour

  def initialize(colour)
    @colour = colour
    puts "Found in Animal Class"
  end
end

class Cat < Animal
  def colour
    puts "Checked in Cat class / "
    super
  end
end

cat1 = Cat.new('Black')
cat1.colour
# >> Found in Animal Class
# >> Checked in Cat class /