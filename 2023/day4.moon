require"moon.all"

pp = {}
sum=0
for card, win, match in io.open"day4.txt"\read"*a"\gmatch"(%d+): (.-) | (.-)\n"
  card = tonumber card
  mm = {}
  for m in match\gmatch"%d+"
    mm[m] = true

  o = 0
  local i
  for w in win\gmatch"%d+"
    if mm[w]
      i = (i and i * 2 or 1)
      o+=1
  if i
    sum += i
  aa = {}
  pp[card] = aa
  for a = card+1, card+o
    table.insert(aa, a)

print sum

sss = 0
add = (card) ->
  sss += 1
  for to in *pp[card]
    add(to)

for i = 1, #pp
  add(i)

print sss
