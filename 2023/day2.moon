max= red: 12, green: 13, blue: 14
sum=0
pwr=0
for id, games in io.open"day2.txt"\read"*a"\gmatch"Game (%d+): (.-)\n"
  g=true
  min={}
  for game in games\gmatch"[^;]+"
    e={}
    for n, color in game\gmatch"(%d+) (%w+)"
      n=tonumber n
      e[color]or=0
      e[color]+=n
      if e[color] > max[color]
        g = false
      if not min[color] or min[color] < n
        min[color] = n
  pp=1
  pp*=n for _, n in pairs min
  pwr+=pp
  if g
    sum+=id

print sum
print pwr
