class Book
  attr_reader :author, :title # This single line was added to provided code

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Expected output:
# >> The author of "Snow Crash" is Neil Stephenson.
# >> book = "Snow Crash", by Neil Stephenson.

=begin
FURTHER EXPLORATION

Q: What are the differences between attr_reader, attr_writer, and
attr_accessor? Why did we use attr_reader instead of one of the other two?
Would it be okay to use one of the others? Why or why not?

A: attr_reader/attr_writer/attr_accessor create getter/setter/getter and setter
methods. attr_reader was used instead of the other two because the use of the
class only demonstrated the need for two getter methods, so it was best to keep
the states of the class unmodifiable unless necessary. It'd be not okay to use
attr_writer in the use case of lines 14 to 16, because book.title and
book.author are clearly invocations of two getter methods (for @author and
@title, respectively). attr_accessor would work, but creating unncessary setter
methods might bring other potential concerns.
=end

=begin
Q: Instead of attr_reader, suppose you had added the following methods to this
class:

def title
  @title
end

def author
  @author
end

Would this change the behavior of the class in any way? If so, how? If not, why
not? Can you think of any advantages of this code?

A: No, because attr_reader :title is essentially:

def title
  @title
end

And attr_reader :author is also essentially:

def author
  @author
end

An advantage that I can think of is these explicit method definitions take up
more lines in the class definintion, so a user of the code base may be more
aware of their existence. If a class spans, say, over a page worth of lines, a
user could forget which getter and/or setter methods are created with attribute
accessors at the beginning of the class definition.

LSBot:
You might also consider that explicit method definitions offer more
flexibility—if you later need to add validation, formatting, or other logic to
the getter methods, you can easily modify the explicit methods without changing
the interface. With attr_reader, you'd need to remove it and write the methods
manually.
=end
