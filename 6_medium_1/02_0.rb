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
    if index > @upper_bound || index < @lower_bound
      raise IndexError, 'index is out of array bounds'
    end
    @fixed_array[index] = value
  end

  def to_a
    @fixed_array
  end

  def to_s
    @fixed_array.to_s
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end
