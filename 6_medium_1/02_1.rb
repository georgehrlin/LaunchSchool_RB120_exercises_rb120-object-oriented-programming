# Implemented LSBot recommendations
class FixedArray
  def initialize(length)
    @length = length
    @upper_bound = length - 1
    @lower_bound = -length
    @fixed_array = Array.new(length)
  end

  def [](index)
    if index > @upper_bound || index < @lower_bound
      raise IndexError, 'index is out of array bounds'
    end
    @fixed_array.[](index)
  end

  def []=(index, value)
    self.[](index) # This uses lines 10 to 12 to check for IndexError
    @fixed_array.[]=(index, value)
  end

  def to_a
    @fixed_array.clone # Using clone here protects @fixed_array from mutation
  end

  def to_s
    @fixed_array.to_s
  end
end
