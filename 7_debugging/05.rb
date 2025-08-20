=begin
Without running the faulty code, I believe the NameError mentioned in the
original question, which complains about an uninitialized constant
File::FORMAT, has to do with no FORMAT is initialized in the class File.

When blog_post, a MarkdownFile object, is passed to puts on line 45, to_s is
called on blog_post implicitly. File#to_s is called and references FORMAT.
Here, Ruby looks for a FORMAT constant in the File class first but cannot find
one. It then moves out of the class and looks for a FORMAT in the main frame,
also to no avail, thus raising a NameError. FORMAT is only available in the
subclasses of File, which are not searched by Ruby in this code example.
=end

# My fix:
class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post

=begin
NOTES
"When Ruby resolves a constant, it looks it up in its lexical scope. In this
case with FORMAT, it is looked up in the File class as well as in all of its
ancestor classes. Because Ruby does not find FORMAT in any of them, it throws
a NameError."
=end
