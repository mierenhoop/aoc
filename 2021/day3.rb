e = ARGF.lines.map{|x|x.chomp.chars}.transpose.map{|x|(x.count("0") < x.size / 2) ? "1" : "0"}.join
p e.to_i(2) * e.tr("10","01").to_i(2)
