require 'pry-byebug'

class CircularBuffer
  @@turn_num = 0

  def initialize(size)
    @buffer = Array.new(size, CircularBufferElement.new(nil, @@turn_num))
  end

  def put(ele)
    @@turn_num += 1
    new_ele = CircularBufferElement.new(ele, @@turn_num)

    begin
      if @buffer.all? { |ele| ele.ele.nil?}
        @buffer.unshift(new_ele)
      else
        most_recent_idx = @buffer.index(ele_most_recently_added)
        oldest_idx = @buffer.index(ele_oldest_turn_added)
        if @buffer[most_recent_idx + 1] != nil
          @buffer[oldest_idx] = new_ele
        else
          @buffer[most_recent_idx + 1] = new_ele
        end
      end
    rescue StandardError
      binding.pry
    end
  end

  def ele_most_recently_added
    @buffer.max_by { |ele| ele.turn_added }
  end

  def ele_oldest_turn_added
    @buffer.min_by { |ele| ele.turn_added}
  end

  def get
    @@turn_num += 1

    if @buffer.all? { |ele| ele.ele.nil? }
      nil
    else
      @buffer.delete(ele_oldest_turn_added).ele
    end
  end
end





buffer = CircularBuffer.new(3)
p buffer
p buffer.get # == nil

buffer.put(1)
p buffer
buffer.put(2)
p buffer
binding.pry

p buffer.get # == 1

# buffer.put(3)
# buffer.put(4)
# puts buffer.get # == 2