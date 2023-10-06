
#e = ARGF.lines.map do |l|
#    l.split("|")[1].chomp.split.map{{2 => 1, 4 => 4, 3 => 7, 7 => 8}[_1.size]}.compact.size
#end.sum

#p e

oo = []

ARGF.lines.each do |l|
    conf, out = l.split("|")

    pos = []
    yes = []
    (0..6).each do |x| pos[x] = "abcdefg".chars end
    conf.chomp.split.each do |a|
        if a.size == 3
            [0, 1, 2].each do |i| 
                pos[i] &= a.chars
            end
            [3, 4, 5, 6].each do |i| 
                pos[i] -= a.chars
            end
        elsif a.size == 2
            [1, 2].each do |i| 
                pos[i] &= a.chars
            end
            [0, 3, 4, 5, 6].each do |i|
                pos[i] -= a.chars
            end
        elsif a.size == 4
            [1, 2, 5, 6].each do |i| 
                pos[i] &= a.chars
            end
            [0, 3, 4].each do |i|
                pos[i] -= a.chars
            end
        end
    end
    pos[0] = pos[0][0]
    pos[1] = pos[1][0]
    pos[2] = pos[2][1]
    pos[3] = pos[3][0]
    pos[4] = pos[4][1]
    pos[5] = pos[5][0]
    pos[6] = pos[6][1]
    pos.delete_at(7)

    answr = []

    out.chomp.split.each do |o|
        ind = o.chars.map{|c| pos.find_index(c)}
        if o.size == 3
            answr << "7"
        elsif o.size == 2
            answr << "1"
        elsif o.size == 4
            answr << "4"
        elsif o.size == 4
            answr << "1"
        elsif o.size == 7
            answr << "8"
        elsif o.size == 5
            if ind.include? 1 and ind.include? 2
                answr << "3"
            elsif ind.include? 3 and ind.include? 4
                answr << "2"
            else
                answr << "5"
            end
        elsif o.size == 6
            if not (ind.include? 1 and ind.include? 2)
                answr << "6"
            elsif ind.include? 3 and ind.include? 4
                answr << "0"
            else
                answr << "9"
            end
        end
    end
    oo << answr.join.to_i
end
p oo.sum
