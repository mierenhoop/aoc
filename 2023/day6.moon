require"moon.all"
input = io.open"day6.txt"\read"*a".."\n"

times = [tonumber t for t in input\match"Time:(.-)\n"\gmatch"%d+"]
ds = [tonumber d for d in input\match"Distance:(.-)\n"\gmatch"%d+"]

map = {times[i], ds[i] for i = 1, #times}

mul=1
for time, dist in pairs map
  s = 0
  for n = 1, time
    nd = n * (time-n)
    if nd > dist
      s+=1
  mul *= s

print mul

time = tonumber table.concat times
dist = tonumber table.concat ds

s=0
for n = 1, time
  nd = n * (time-n)
  if nd > dist
    s += 1

print s
