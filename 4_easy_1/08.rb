class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(width) # Perhaps side_length is a more precise name
    super(width, width)
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"
