require 'set'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  attr_accessor :stack, :register

  def initialize(program)
    @program = program
  end

  def eval(format_argument=nil)
    formatted_program =
      format_argument.nil? ? @program : format(@program, format_argument)
    @stack = []
    @register = 0
    formatted_program.split.each { |token| eval_token(token) }
  rescue MinilangError => error
    puts error.message
  end

  private

  def eval_token(token)
    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    @stack.push(@register)
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end

  def add
    @register += pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def mult
    @register *= pop
  end

  def sub
    @register -= pop
  end

  def print
    puts @register
  end
end

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval

# >> means output, not return value
CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'

minilang1 = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang1.eval(degrees_c: 100) # >> 212
minilang1.eval(degrees_c: 0)   # >> 32
minilang1.eval(degrees_c: -40) # >> -40

MILES_PER_HOUR_TO_YARDS_PER_HOUR = 
  '1760 PUSH %<miles>d MULT PRINT'

minilang2 = Minilang.new(MILES_PER_HOUR_TO_YARDS_PER_HOUR)
minilang2.eval(miles: 1)  # >> 1760
minilang2.eval(miles: 50) # >> 88000

AREA_OF_A_RECTANGLE =
  '%<length>d PUSH %<width>d MULT PRINT'

minilang3 = Minilang.new(AREA_OF_A_RECTANGLE)
minilang3.eval(length: 10, width: 5) # >> 50
minilang3.eval(length: 50, width: 5) # >> 250
