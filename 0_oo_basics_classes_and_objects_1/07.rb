class Cat
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{name}!"
  end

=begin
  # Creating the getter method manually
  def name
    @name
  end
=end
end

kitty = Cat.new('Sophie')
kitty.greet
