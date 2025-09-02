# Implement LSBot suggestions and clarifications again again
class EmptyStackError < StandardError; end

class InvalidTokenError < StandardError; end

class Minilang
  COMMANDS = %w[PUSH ADD SUB MULT DIV MOD POP PRINT]

  def initialize(program)
    @operations = program.split
    @register = 0
    @stack = []
  end

  def eval
    begin
      @operations.each do |operation|
        if operation =~ /\A[-+]?\d+\z/
          send(:update_register, operation.to_i)
        elsif COMMANDS.include?(operation)
          send(operation.downcase)
        else
          raise InvalidTokenError, "Invalid token: #{operation}"
        end
      end
    rescue EmptyStackError => e
      puts e.message
    rescue InvalidTokenError => e
      puts e.message
    end
  end

  private

  def print
    puts @register
  end

  def update_register(n)
    @register = n
  end

  def push
    @stack << @register
  end

  def add
    @register += pop
  end

  def sub
    @register -= pop
  end

  def mult
    @register *= pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def pop
    raise EmptyStackError, 'Empty stack!' if @stack.empty?
    @register = @stack.pop
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
