class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels # This contradicts the approach in the official solution
    4        # My reasoning is included below as part of my response to
  end        # Further Exploration

  def to_s
    "#{make} #{model}"
  end
end


class Car < Vehicle; end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

=begin
FURTHER EXPLORATION

Q: Would it make sense to define a wheels method in Vehicle even though all of
the remaining classes would be overriding it? Why or why not? If you think it
does make sense, what method body would you write?

A: Defining a wheels method in Vehicle is actually what I diecided to do when I
first approached this exericse, and I defined the method to return 4. My
thought process behind it is that, conceptually, the far majority of vehicles
run on four wheels. (Sure, a small portion of vehicles run on tracks, but that
is honestly a tiny fraction, at least as far as non-commercial vehicles go.)
Whether my decision to have Vehicle#wheels return 4 by default can be debated,
but I believe even most trucks run on four wheels.

A superclass should be defined to cover the majority of cases of what this
class is trying to represent. Therefore I think a wheels method should be
inlucded in the Vehicle class.
=end

# Alternative suggested by LSBot
class Vehicle
  # ...
  def wheels
    raise NotImplementedError, "Every Vehicle subclass must implement its own #wheels method."
  end
end
