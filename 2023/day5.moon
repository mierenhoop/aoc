require"moon.all"

input = io.open"day5.txt"\read"*a".."\n\n"

seeds = [tonumber a for a in input\match"seeds: (.-)\n"\gmatch"%d+"]

gg = {}

for fro, to, map in input\gmatch"(%w+)%-to%-(%w+) map:%s+(.-\n)\n"
  mm = {:to}
  gg[fro] = mm

  for dest, source, len in map\gmatch"(%d+) (%d+) (%d+)\n"
    dest = tonumber dest
    source = tonumber source
    len = tonumber len
    table.insert mm, {:dest, :source, :len}
  table.sort mm, (a, b) -> a.source < b.source


all = {}
for seed in *seeds
  name = "seed"
  v = seed
  while true
    nxt = gg[name]

    for {:source,:dest,:len} in *nxt
      if v >= source and v < source + len
        v = v - source + dest
        break

    name = nxt.to
    break if not gg[name]
  table.insert all, {:seed, :v}
table.sort all, (a, b) -> a.v < b.v

print all[1].v
