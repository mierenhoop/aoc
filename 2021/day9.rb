require "set"

@d = ARGF.lines.map{_1.chomp.chars.map(&:to_i)}

arr = []
brr = []

def getneigh x, y
    ns = []
    ns << [x, y - 1] if y > 0
    ns << [x, y + 1] if y + 1 < @d.size
    ns << [x - 1, y] if x > 0
    ns << [x + 1, y] if x + 1 < @d[y].size
    ns
end

@p = Set.new

def getall x, y
    @p << [x, y]
    a = getneigh(x, y).reject {|x2, y2| @p.include? [x2, y2] }.select {|x2, y2| @d[y][x] <= @d[y2][x2] and @d[y2][x2] != 9}
    a + a.map{|x2, y2| getall x2, y2}.flatten(1)
end


la = @d[0].size
la.times.to_a.product(@d.size.times.to_a).each do |x, y|
    lower = getneigh(x, y).all? { |x2, y2| @d[y][x] < @d[y2][x2] }
    if lower
        sz = getall(x, y).uniq.size
        brr << sz + 1 if sz != 0
        arr << @d[y][x].succ
    end
end

p "Part 1", arr.sum
p "Part 2", brr.sort.reverse.take(3).reduce :*
