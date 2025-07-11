module Transportation
  class Vehicle; end
  class Truck < Vehicle; end
  class Car < Vehicle; end
end

truck1 = Transportation::Truck.new

puts person1.compare_secret(person2)

# From Nick Johnson
module Transportation
  Vehicle = Class.new
  %w[Truck Car].each { |vehicle| eval("#{vehicle} = Class.new(Vehicle)")}
end
