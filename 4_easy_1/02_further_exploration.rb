class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 42
fluffy = Pet.new(name) # @name -> "42"
name += 1              # name -> 43
puts fluffy.name       # >> 42
puts fluffy            # >> My name is 42.
puts fluffy.name       # >> 42
puts name              # >> 43

=begin
On line 13, the local variable is initialized with a an integer value 42.

On line 14, a new instance of the Pet class is instantiated with new and the
integer 42 passed in as an argument. Execution moves on to line 4, where the
parameter name is assigned 42. On line 5, to_s is called on name and returns a
string "42", which is in turn assigned to the instance variable @name. This new
Pet object finally is stored in a new local variable fluffy.

On line 15, the local variable name is reassigned to integer 43.

On line 16, the instance method name is called on fluffy and it returns the
value of @name, which is 42. puts then calls to_s implicitly on 42, turning it
into a string, "42", and outputs 42.

On line 17, puts is called with fluffy as an argument. to_s is implicitly
called on fluffy. Because fluffy belongs to the Pet class, Ruby searches up the
method lookup path and finds the overriding Pet.to_s, so execution moves on to
line 8. Line 9 returns the string "My name is FLUFFY.", which is returned by
the to_s and then output by puts as: My name is 42.

On line 18, the same thing happens as does line 16.

On line 19, puts is invoked with the local variable name as an argument. This
outputs 43.
=end
