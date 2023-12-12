require"moon.all"

combs = (l, i, ns) ->
  n = table.remove(ns, 1)
  sum = 0

  ni = l\find "#", i
  while true
    i = l\find ("[#?]"\rep(n).."[^#]"), i

    break if not i

    if ni and ni < i
      break

    i+=1

    if #ns > 0
      sum += combs(l, n+i, [n for n in *ns])
    else
      if not l\find "#", i+n
        sum+=1
  sum


sum=0
for line in io.open"day12.txt"\lines!
  s = combs line, 1, [tonumber num for num in line\gmatch"%d+"]
  print s
  sum += s

print sum

