# Rewrote after peeking at solution
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def initialize(year)
    # Invoking super without () here passes all args to Vehicle#initialize
    super
    start_engine
  end

  def start_engine
    puts 'Ready to go!'
  end
end

p truck1 = Truck.new(1994)
puts truck1.year
