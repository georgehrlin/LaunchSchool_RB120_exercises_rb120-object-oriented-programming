class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

=begin
Q: There is nothing technically incorrect about this class, but the definition
may lead to problems in the future. How can this class be fixed to be resistant
to future problems?

A: (First attempt)
Honestly, (without looking at Hint, I am not entirely sure, but here is my
take: When a Flight object is instantiated, @database_handle is assigned to a
new instance of Database, creating a composition relationship between the two
objects. Now, the attribute accessor on line 2 creates a getter and setter for
@database_handle. My suspicion of a potential problem is that the setter method
allows for the reassignment of @database_handle to a different object, which
breaks the composition of the Flight object and the Database objct, and should
be invalid or at least unintentional.

I can be wrong that Databse.init creates a new object. I've never seen this
kind of code before. I've never used the init method and I've never been
introduced to dabatase. I honestly don't know what this question is trying to
get at.

A: (Second attempt)
The Hint suggests: "Consider what might happen if you leave this class defined
as it is, and later decide to alter the implementation so that a database is
not used." Well in that case I'd get rid of lines 2 and 5 altogether if there
is no more use for @database_handle. I still don't get the point of this
question.
=end
