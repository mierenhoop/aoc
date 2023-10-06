class Integer
    def - a
        itself * a
    end
    def / a
        itself + a
    end
end

lines = ARGF.lines.to_a

puts "Part 1", lines.sum{eval(_1.tr "*","-")}
puts "Part 2", lines.sum{eval(_1.tr "*+","-/")}
