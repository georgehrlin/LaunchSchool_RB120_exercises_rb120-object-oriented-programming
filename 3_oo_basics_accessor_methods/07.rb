=begin
# First solution
class Person
  attr_writer :name

  def name
    "Mr. #{@name}"
  end
end
=end

# Second solution
class Person
  attr_reader :name

  def name=(name)
    @name = "Mr. #{name}"
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name
