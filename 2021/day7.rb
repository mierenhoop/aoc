e = ARGF.lines.first.split(",").map(&:to_i)
a = (e.min .. e.max).map{|t|e.map{|x|(x-t).abs}}

puts "Part 1", a.map(&:sum).min
puts "Part 2", a.map{|t|t.map{|n|(n+1)*n/2}.sum}.min
