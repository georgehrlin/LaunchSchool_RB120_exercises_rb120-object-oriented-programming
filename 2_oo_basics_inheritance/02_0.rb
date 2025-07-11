# Initial attempt
# Works, but not quite what the question intended...
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
    start_engine
  end
end

class Truck < Vehicle
  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year
