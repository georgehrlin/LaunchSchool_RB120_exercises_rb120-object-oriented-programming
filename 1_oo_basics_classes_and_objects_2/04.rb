class Cat
  attr_reader :name

  def self.generic_greeting
    puts "Hi! I'm a cat. Meow~ :3"
  end

  def initialize(name)
    @name = name
  end

  def personal_greeting
    puts "Nice to meet ya meow~ I'm #{name}. :D"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting
