module Towable
  def tow
    'I can tow a trailer!'
  end
end

class Vehicle
  attr_accessor :year

  def initialize(year)
    self.year = year # @year = year is preferred here, actually
  end
end

class Truck < Vehicle
  include Towable
end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year
puts truck1.tow

car1 = Car.new(2006)
puts car1.year
