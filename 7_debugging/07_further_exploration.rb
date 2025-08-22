=begin
FURTHER EXPLORATION
Q: What will the return value of a setter method be if you mutate its argument
in the method body?

A: In the case that a mutable object was passed into a setter method as an
argument and the setter method mutated this object: I've never tested this, but
I believe that the setter method would return the mutated object because it is
the same object, and a setter method always returns the argument object.
=end

# Test
class MyClass
  attr_reader :ivar

  def ivar=(mutable)
    @ivar = mutable.upcase!
  end
end

obj = MyClass.new
p obj.ivar = 'hello'
