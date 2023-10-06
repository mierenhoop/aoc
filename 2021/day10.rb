ot = []
o = ARGF.lines.filter_map do |l|
    arr = []
    inv = nil
    l.chomp.chars.each do |c|
        if "({[<".chars.include? c
            arr << c
        else
            o = arr.pop
            if not inv and {"("=> ")", "{"=> "}", "["=>"]", "<"=>">"}[o] != c
                inv = c
            end
        end
    end
    ot << arr.dup if not inv
    inv
end
puts "Part 1", o.map{{")"=>3,"]"=>57,"}"=>1197,">"=>25137}[_1]}.sum
ot = ot.reverse.map{|x|x.reverse.map{_1.tr("([{<","1234").to_i}.reduce(0) {|a, b| a * 5 + b}}.sort
puts "Part 2", ot[(ot.size - 1) / 2]
