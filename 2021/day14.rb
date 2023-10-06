a, *b = ARGF.lines.map(&:chomp).reject(&:empty?)
h = b.map{_1.split(" -> ")}.to_h
# 10.times do
#     a = a[0] + a.chars.each_cons(2).map{h[_1.join] + _1[1] }.join
# end
# p a.chars.tally.sort_by{_2}.rotate(-1).take(2).map(&:last).inject(:-)

f = h.dup
f.each {|c, b| f[c] = [c[0] + b, b + c[1]]}
g = h.dup
g.keys.each {|c| g[c] = 0 }

a.chars.each_cons(2).map(&:join).each do |c|
    f[c].each do |b|
        g[b] += 1
    end
end

39.times do
    s = {}
    g.each do |c, t|
        f[c].each do |b|
            s[b] = 0 if s[b] == nil
            s[b] += t
        end
    end
    g = s
end

y = {}
g.each do |c, d|
    y[c[0]] = 0 if y[c[0]] == nil
    y[c[0]] += d
end
y[a.chars.last] += 1
p y.sort_by{_2}.rotate(-1).take(2).map(&:last).inject(:-)
