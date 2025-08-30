arr = %w(a b c d e f g)

arr.each do |char|
  arr.insert(rand(0...arr.size), arr.delete(char))
end

p arr