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

input = io.open"day5.txt"\read"*a".."\n\n"

seeds = for l, len in input\match"seeds: (.-)\n"\gmatch"(%d+) (%d+)"
  l=tonumber l
  r=l-1+tonumber len
  {:l, :r}

for fro, to, map in input\gmatch"(%w+)%-to%-(%w+) map:%s+(.-\n)\n"
  mm = {}
  for dest, source, len in map\gmatch"(%d+) (%d+) (%d+)\n"
    l = tonumber source
    r = l - 1 + tonumber len
    diff = (tonumber dest) - l
    table.insert mm, {:l, :r, :diff}
  table.sort mm, (a, b) -> a.l < b.l


  fill = (l, r) ->
    if l < r
      {:l, r: r-1}

  overlap = (l, r) ->
    if l <= r
      {:l, :r}

  out = {}

  table.sort seeds, (a, b) -> a.l < b.l

  mi = 1

  for {:l, :r} in *seeds
    while true
      m = mm[mi]
      if not m
        table.insert out, {:l, :r, diff: 0}
        break
      
      if m.l <= l
        if l <= m.r
          if r <= m.r -- TODO: or < ?
            table.insert out, {:l, :r, diff: m.diff}
            break
          table.insert out, {:l, r: m.r, diff: m.diff}
          l = m.r+1
        else
          mi += 1
      else
        nr = math.min(m.l-1, r)
        table.insert out, {:l, r: nr, diff: 0}
        l = nr+1
        break
  for e in *out
    e.l += e.diff
    e.r += e.diff
  seeds = out
  
table.sort seeds, (a, b) -> a.l < b.l

print seeds[1].l
