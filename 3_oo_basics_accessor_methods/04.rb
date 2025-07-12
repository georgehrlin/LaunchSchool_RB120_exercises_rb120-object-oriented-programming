class Person
  attr_accessor :first_name
  attr_writer :last_name


  def first_equals_last?
    first_name == last_name # A last_name getter method is necessary here
  end

  # CORRECTION
  # I was missing the following:
  private

  attr_reader :last_name
end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last? # Expected output: false
