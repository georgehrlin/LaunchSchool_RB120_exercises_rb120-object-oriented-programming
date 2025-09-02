class Minilang
  def initialize(program)
    @operations = program.split
    @register = 0
    @stack = []
    run
  end

  private

  def run
    begin
      @operations.each do |operation|
        if operation.to_i.to_s == operation
          send(:update_register, operation.to_i)
        else
          send(operation.downcase)
        end
      end
    rescue NoMethodError
      puts "Invalid token!"
    end
  end

  def print
    if @register.nil?
      puts 'Empty stack!'
    else
      puts @register
    end
  end

  def update_register(n)
    @register = n
  end

  def push
    @stack << @register
  end

  def add
    @register += @stack.pop
  end

  def sub
    @register -= @stack.pop
  end

  def mult
    @register *= @stack.pop
  end

  def div
    @register /= @stack.pop
  end

  def mod
    @register %= @stack.pop
  end

  def pop
    @register = @stack.pop
  end
end

# Test
Minilang.new('PRINT')
# 0

Minilang.new('5 PUSH 3 MULT PRINT')
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT')
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT')
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT')
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT')
# 8

Minilang.new('6 PUSH')
# (nothing printed; no PRINT commands)
