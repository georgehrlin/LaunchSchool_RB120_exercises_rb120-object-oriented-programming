Towable = Module.new { define_method(:tow) { puts 'I can tow a trailer!' } }

Truck = Class.new { include Towable }
Car = Class.new

truck1 = Truck.new
truck1.tow

# For compare-and-contrast
module Towable
  def tow
    puts "I can tow a trailer!"
  end
end

class Truck
  include Towable
end

class Car
end

truck1 = Truck.new
truck1.tow
