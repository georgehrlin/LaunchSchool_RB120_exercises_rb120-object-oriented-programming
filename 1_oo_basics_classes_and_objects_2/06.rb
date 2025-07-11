class Cat
  COLOUR = 'purple'

  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{@name} and I'm a #{COLOUR} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
