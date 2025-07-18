class SomeClass
  attr_reader :ivar

  def initialize(some_str)
    @ivar = some_str
  end

  def to_s
    "Hiiiiii"
  end
end

a = SomeClass.new('Heyyy')
puts a
