class Cat
  def Cat.generic_greeting # self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

=begin
FURTHER EXPLORATION

Q: What happens if you run kitty.class.generic_greeting? Can you explain this
result?

A: Without running `kitty.class.generic_greeting`, I believe this code outputs:
Hello! I'm a cat. This is because the class instance method returns the class
of the calling object, so kitty.class returns Cat, which then allows the class
method generic_greeting to be called on the class Cat.
=end

kitty = Cat.new
kitty.class.generic_greeting
