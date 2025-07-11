# List of the classes or modules checked by Ruby when searching for #color:
# Bird
# Flyable
# Animal

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color

# From Ying Chyi Gooi
color_method_class = bird1.method(:color).owner # => Animal
bird1_ancestors = bird1.class.ancestors # => [Bird, Flyable, Animal, Object, Kernel, BasicObject]
puts bird1_ancestors[0..bird1_ancestors.index(color_method_class)]
