class Person
  def age=(num)
    @age = num * 2
  end

  def age
    @age * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age # Expected output: 80

# Food for thought
class Person
  def age=(num)
    @age = double(num)
  end

  def age
    double(@age)
  end

  private

  def double(n)
    n * 2
  end
end
