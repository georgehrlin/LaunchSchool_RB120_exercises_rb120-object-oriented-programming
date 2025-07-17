class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    self.mileage = mileage + miles
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678

=begin
NOTES

(From Official Solution)
It's generally safer to use an explicit self. caller when you have a setter
method unless you have a good reason to use the instance variable directly. We
say that calling the setter method, if available, is safer because using the
insance variable bypasses any checks or operations performed by the setter
=end
