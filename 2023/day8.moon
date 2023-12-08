require"moon.all"

input = io.open"day8.txt"\read"*a"

dirs = [a for a in input\match"[RL]+"\gmatch"."]

nodes = {fro, {:L, :R} for fro, L, R in input\gmatch"(%w+) = %((%w+), (%w+)%)"}

fin = "ZZZ"

walk = () ->
  steps = 0
  cur = "AAA"
  while true
    for dir in *dirs
      cur = nodes[cur][dir]
      steps += 1
      return steps if cur == fin

print walk!

