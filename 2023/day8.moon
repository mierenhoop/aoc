input = io.open"day8.txt"\read"*a"

dirs = input\match"[RL]+"

nodes = {fro, {:L, :R} for fro, L, R in input\gmatch"(%w+) = %((%w+), (%w+)%)"}

walk = (cur, fin) ->
  steps = 0
  while true
    for dir in dirs\gmatch"."
      cur = nodes[cur][dir]
      steps += 1
      return steps if cur\match fin

print walk "AAA", "ZZZ"

a=1
for start in *[n for n in pairs nodes when n\match"Z$"]
  a *= walk(start, "Z$") / #dirs

print a*#dirs
