class Cat
  @@num_total_cats = 0

  def self.total
    puts @@num_total_cats
  end

  def initialize
    @@num_total_cats += 1
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total
