class Person
  attr_writer :age # Attribute accessors

  def older_than?(other)
    age > other.age
  end

  protected # Called an access modifier

  attr_reader :age
end

person1 = Person.new
person1.age = 17

person2 = Person.new
person2.age = 26

puts person1.older_than?(person2)
