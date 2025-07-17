class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Expected output:
# >> The author of "Snow Crash" is Neil Stephenson.
# >> book = "Snow Crash", by Neil Stephenson.

=begin
FURTHER EXPLORATION

Q: What do you think of this way of creating and initializing Book objects?
(The two steps are separate.) Would it be better to create and initialize at
the same time like in the previous exercise? What potential problems, if any,
are introduced by separating the steps?

A: I think it'd be better to create an object and initialize it with the values
for its state in one step, given that the definition of the class is
accessible (so one knows how many values and in what order to pass them in).
Other than being more succinct than separating it into multiples lines, the
number of which depends on the number of the state values, keeping it in one
line saves the need to create setter methods if they are not necessary
otherwise. Separating the steps would fail if the getter methods were not
already created.

LSBot: The main issue of creating an object on separate lines is that we can
create a Book object that exists in an incomplete or invalid state (it has no
state—none of its instance variables are assinged values). If other parts of a
program expects every Book object to have a title, for instance, this could
lead to bugs.

By Using an initialize method that requires arguments for title and author, we
can enforce a rule: a Book object cannot be created unless it's given the data
it needs to be valid. This is a key concept in desgining reliable objects.
=end
