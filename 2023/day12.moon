require"moon.all"

combs = (l, i, ns, a) ->
  n = table.remove(ns, 1)
  a-=n
  sum = 0

  ni = l\find "#", i, true
  while true
    i = l\find ("[#?]"\rep(n).."[^#]"), i

    break if not i

    if ni and ni < i
      break

    i+=1

    if #ns > 0
      --if #l-i >= a
      sum += combs(l, n+i, [n for n in *ns], a)
    else
      if not l\find "#", i+n, true
        sum+=1
  sum


sum=0
for line in io.open"day12.txt"\lines!
  ns = [tonumber num for num in line\gmatch"%d+"]
  
  line = line\match"[%.?#]+"

  line = line\rep(5)
  l = #ns
  for o = 1, 4
    for i = 1, l
      table.insert ns, ns[i]

  a=0
  a+=n for n in *ns

  print line
  p ns

  s = combs (line.." "), 1, ns, a
  print s
  sum += s

print sum

