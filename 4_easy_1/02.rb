=begin
Q: What output does this code print?

A: Without running the provided code, I think execution will raise a
   NoMethodError when it moves on to line 9.

   Here is my reasoning:
   On line 15, a new Pet object is instantiated with new and "Fluffy" passed in
   as an argument.

   Execution moves on to line 4, where the parameter name takes on the string
   value "Fluffy". Next, on line 5, to_s is called on name. Ruby then invokes
   the to_s defined on line 8 because to_s is overriden.

   Now, execution moves on to line 9, and it raises a NoMethodError because
   upcase! is called on @name, which still points to nil because the
   reassignment of @name on line 5 has not received an argument yet, and there
   is no upcase! defined for nil.

WRONG!

CORRECTION:
The to_s invocation on line 5 does not invoke Pet.to_s because to_s is invoked
on a String object. Here, @name is assigned to "Fluffy".

Continuing with this correction, line 16 outputs Fluffy.

On line 17, because puts implicitly invokes to_s, Pet.to_s is called on fluffy.
Execution moves on to line 9, where upcase! is called on @name, mutating @name
by capitalizing all of its characters. Then, because line 10 is a string of the
value "My name is FLUFFY.", this is what is returned and passed to puts. puts
on line 17 outputs My name is FLUFFY.

Line 18 outputs FLUFFY. Line 19 still outputs Fluffy because to_s on line 5
returned a new string.

STILL WRONG (a part of it)!

CCORRECTION:
The to_s on line 5 in fact does not return a new string when it is called on a
String object. Therefore both @name and the local variable initialized on line
14 refer to the same string object. Line 19 outputs FLUFFY.

Line 16 outputs: Fluffy
Line 17 outptus: My name is FLUFFY.
Line 18 outputs: FLUFFY
Line 19 outputs: FLUFFY
=end

class Pet
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
