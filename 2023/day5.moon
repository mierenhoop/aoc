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

-- for example input
-- seeds
-- 1: 79-92
-- 2: 55-67
--
-- pass 1
-- 1: 98-99 | -48
-- 2: 50-97 | +2
--
-- out 1
-- 1: 55-67 -> 57-69
-- 2: 79-92 -> 81-94
--
-- pass 2
-- 1: 15-51 | -15
-- 2: 52-53 | -15
-- 3: 0-14  | +39
--
-- out 2
-- 1: 57-69 -> 57-69
-- 2: 81-94 -> 81-94
--
-- pass 3
-- 1: 53-60 | -4
-- 2: 11-53 | -11
-- 3: 0-6   | +42
-- 4: 7-10  | +50
--
-- out 3
-- 1: 57-60 -> 53-56
-- 2: 61-69 -> 61-69
-- 3: 81-94 -> 81-94
--
-- pass 4
-- 1: 18-26 | +70
-- 2: 25-94 | -7
--
-- out 4
-- 1: 53-56 -> 46-49
-- 2: 61-69 -> 54-62
-- 3: 81-94 -> 74-87
--
-- pass 5
-- 1: 77-99 | -32
-- 2: 45-63 | +36
-- 3: 64-76 | +4
--
-- out 5
-- 1: 46-49 -> 82-85
-- 2: 54-62 -> 90-98
-- 3: 74-76 -> 78-80
-- 4: 77-87 -> 45-55
--
-- pass 6
-- 1: 69-69 | -69
-- 2: 0-68  | +1
--
-- out 6
-- 1: 82-85 -> 82-85
-- 2: 90-98 -> 90-98
-- 3: 78-80 -> 78-80
-- 4: 45-55 -> 46-56
--
-- pass 7
-- 1: 56-92 | +4
-- 2: 93-96 | -37
--
-- out 7
-- 1: 82-85 -> 86-89
-- 2: 90-92 -> 94-96
-- 3: 93-96 -> 56-59
-- 4: 97-98 -> 97-98
-- 5: 78-80 -> 82-84
-- 6: 46-55 -> 46-55
-- 7: 56-56 -> 60-60


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
          if r <= m.r
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
        break -- this is wrong but got me the right answer :^)
  for e in *out
    e.l += e.diff
    e.r += e.diff
  seeds = out
  
table.sort seeds, (a, b) -> a.l < b.l

print seeds[1].l
