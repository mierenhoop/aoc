a = ARGF.lines.map(&:to_i)
puts "Part 1", a.each_cons(2).map{|x|x.inject:<}.count(&:itself)
puts "Part 2", a.each_cons(3).map(&:sum).each_cons(2).map{|x|x.inject:<}.count(&:itself)
