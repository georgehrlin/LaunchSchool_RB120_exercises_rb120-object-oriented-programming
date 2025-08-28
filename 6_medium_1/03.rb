class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year) # Can also be omitted
    super
  end
end

# FURTHER EXPLORATION
class Unregistered < Student
  def initialize
    super()
  end
end
