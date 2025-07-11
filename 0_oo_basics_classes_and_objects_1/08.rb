class Cat
  attr_accessor :name
  # attr_writer :name # Alternatively

  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{name}!"
  end

=begin
  # Creating the setter manually
  def name=(new_name)
    @name = new_name
  end
=end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = 'Luna'
kitty.greet
