=begin
- A CircularBuffer obj contains CircularBufferElement objs as elements
- CircularBuffer class contains a @@turn_num that keeps track of current turn
  and it begins with 0
- Every CircularBufferElement obj has a @turn_added that keep track of at what
  turn it was added to the circular buffer

When put(ele) is called
  - Increment @@turn_num by 1
  - IF circular buffer only contains nils
    - Put ele at first index
  - ELSIF circular buffer is full
    - Determine the idx of the oldest added ele
    - Assign current ele to the index of oldest added ele
  - ELSIF circular buffer only has one opening (only one nil)
    - Determine the idx of this nil and assign current ele at this idx
  - ELSIF the most recently added ele of buffer is at the last position
    - Determine the idx of the first nil in the buffer and assign current ele
      at this idx
  - ELSIF circular buffer does not only contain nils and it's not full
    - Determine the idx of the most recently added ele
    - Assign current ele to the index of most recently added ele + 1

When get is called
  - Increment @@turn_num by 1
  - IF circular buffer only contains nils
    - Return nil
  - ELSE
    - Determine the idx of the oldest added ele
    - Save val of ele at that idx for returning later
    - Replace ele at that idx with nil
    - Return saved val
=end

require 'pry-byebug'

class CircularBuffer
  @@turn_num = 0

  def initialize(size)
    @buffer = Array.new(size)
  end

  def put(obj)
    @@turn_num += 1
    new_ele = CircularBufferElement.new(obj, @@turn_num)

    if @buffer.all?(nil)
      @buffer[0] = new_ele
    elsif @buffer.all? { |ele| ele.class == CircularBufferElement }
      oldest_idx = @buffer.index(oldest_added_ele)
      @buffer[oldest_idx] = new_ele
    elsif @buffer.select(&:nil?).size == 1
      idx = @buffer.index(nil)
      @buffer[idx] = new_ele
    elsif @buffer.index(most_recently_added_ele) + 1 == @buffer.size
      first_nil_idx = nil
      @buffer.each do |ele|
        if ele.nil?
          first_nil_idx = @buffer.index(ele)
          @buffer[first_nil_idx] = new_ele
          return
        end
      end
    else
      most_recent_idx = @buffer.index(most_recently_added_ele)
      @buffer[most_recent_idx + 1] = new_ele
    end
  end

  def most_recently_added_ele
    @buffer.select { |ele| not_nil?(ele) }.max_by { |ele| ele.turn_added }
  end

  def oldest_added_ele
    @buffer.select { |ele| not_nil?(ele) }.min_by { |ele| ele.turn_added }
  end

  def not_nil?(obj)
    obj != nil
  end

  def get
    @@turn_num += 1

    if @buffer.all?(nil)
      nil
    else
      oldest_idx = @buffer.index(oldest_added_ele)
      to_be_returned = @buffer[oldest_idx].val
      @buffer[oldest_idx] = nil
      to_be_returned
    end
  end

  def to_s
    vals = (@buffer.map do |ele|
      if ele.nil?
        nil
      else
        ele.val
      end
    end)
    vals
  end
end

class CircularBufferElement
  attr_reader :val, :turn_added

  def initialize(val, turn_num)
    @val = val
    @turn_added = turn_num
  end
end

buffer = CircularBuffer.new(3)
puts buffer.get == nil

buffer.put(1)
buffer.put(2)
puts buffer.get == 1

buffer.put(3)
buffer.put(4)
puts buffer.get == 2

buffer.put(5)
buffer.put(6)
buffer.put(7)
puts buffer.get == 5
puts buffer.get == 6
puts buffer.get == 7
puts buffer.get == nil

buffer = CircularBuffer.new(4)
puts buffer.get == nil

buffer.put(1)
buffer.put(2)
puts buffer.get == 1

buffer.put(3)
buffer.put(4)
puts buffer.get == 2

buffer.put(5)
buffer.put(6)
buffer.put(7)
puts buffer.get == 4
puts buffer.get == 5
puts buffer.get == 6
puts buffer.get == 7
puts buffer.get == nil
