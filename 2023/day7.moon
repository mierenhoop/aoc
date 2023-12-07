require"moon.all"

typorder = {
  five: 1,
  four: 2,
  full: 3,
  three: 4,
  two: 5,
  one: 6,
  high: 7,
}

order = {
  "A": 1,
  "K": 2,
  "Q": 3,
  "J": 4,
  "T": 5,
  "9": 6,
  "8": 7,
  "7": 8,
  "6": 9,
  "5": 10,
  "4": 11,
  "3": 12,
  "2": 13,
}

rate = (set) ->
  local three
  twos = {}
  ones = {}

  for k, v in pairs set
    if v == 5
      return {typ: "five", order[k]}
    if v == 4
      for kk, vv in pairs set
        if vv == 1
          return {typ: "four", order[k], order[kk]}
    if v == 3
      three = order[k]
    if v == 2
      table.insert twos, order[k]
    if v == 1
      table.insert ones, order[k]

  table.sort ones
  table.sort twos

  if three and twos[1]
    return {typ: "full", three, twos[1]}

  if three
    return {typ: "three", three, ones[1], ones[2]}

  if #twos == 2
    return {typ: "two", twos[1], twos[2], ones[1]}

  if #twos == 1
    return {typ: "one", twos[1], ones[1], ones[2], ones[3]}

  return {typ: "high", ones[1], ones[2], ones[3], ones[4], ones[5]}

hands = {}

for cards, bid in io.open"day7.txt"\read"*a"\gmatch"(%w+)%s+(%d+)"
  bid = tonumber bid

  set={}
  set[k] = (set[k] or 0) + 1 for k in cards\gmatch"."

  rating = rate set

  rating.bid = bid
  rating.all = cards

  table.insert hands, rating

rankhands = {}
for a in *hands
  o = typorder[a.typ]
  rankhands[o] or= {}
  table.insert rankhands[o], a

for typ, rankhand in pairs rankhands
  table.sort rankhand, (a, b) ->
    for i = 1, #a.all
      aa = order[a.all\sub(i,i)]
      bb = order[b.all\sub(i,i)]
      if aa < bb
        return true
      elseif aa > bb
        return false

--
sum = 0
a=1
for i = 7, 1, -1
  if rankhands[i]
    for j = #rankhands[i], 1, -1
      sum += rankhands[i][j].bid * a
      a += 1

print sum
