input = File.read("day3.txt")
p input.split("\n").map{|x|
  a, b = x.chars.each_slice(x.size/2).to_a
  a & b
}.map{|x| x[0].ord - ('a'.ord - 1) }
   .map{|x| x < 0 ? x + 58 : x }.sum
a = input.lines
p a.each_slice(3)
   .map{|x| x.map{|f| f.chomp.chars }}
   .map{|r| r[0] & r[1] & r[2] }.flatten
   .map{|x| x[0].ord - ('a'.ord - 1) }
   .map{|x| x < 0 ? x + 58 : x }.sum
