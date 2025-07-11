class Person
  attr_accessor :secret
end


person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret

=begin
# Setting the getter and setter manually:
class Person
  def secret=(msg)
    @secret = msg
  end

  def secret
    @secret
  end
end
=end
