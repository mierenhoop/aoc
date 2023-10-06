x, d, u = 0, 0, 0
ARGF.lines.each do |l|
    dir, n = l.split
    n = n.to_i
    d -= n if dir == "up"
    d += n if dir == "down"
    if dir == "forward"
        x += n
        u += d * n
    end
end
puts "Part 1", x * d
puts "Part 2", x * u
