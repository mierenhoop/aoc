
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

e = () ->
  rate = (set) ->
    four = false
    three = false
    twos = 0
    j = order["J"] == 13 and set["J"] or 0

    for k, v in pairs set
      if v == 5 or v + j == 5
        return "five"
      if v == 4
        four = true
      if v == 3
        three = true
      if v == 2
        twos += 1

    if four or (three and j == 1) or (twos == 2 and j == 2) or j == 3
        return "four"

    if (three and twos == 1) or (twos == 2 and j == 1)
      return "full"

    if three or (twos == 1 and j == 1) or j == 2
      return "three"

    if twos == 2
      return "two"

    if twos == 1 or j == 1
      return "one"

    return "high"

  rankhands = {}
  for cards, bid in io.open"day7.txt"\read"*a"\gmatch"(%w+)%s+(%d+)"
    bid = tonumber bid

    set={}
    set[k] = (set[k] or 0) + 1 for k in cards\gmatch"."

    rating = {typ: rate set}

    rating.bid = bid
    rating.all = cards

    o = typorder[rating.typ]
    rankhands[o] or= {}
    table.insert rankhands[o], rating


  for typ, rankhand in pairs rankhands
    table.sort rankhand, (a, b) ->
      for i = 1, #a.all
        aa = order[a.all\sub(i,i)]
        bb = order[b.all\sub(i,i)]
        if aa < bb
          return true
        elseif aa > bb
          return false

  sum = 0
  a=1
  for i = 7, 1, -1
    if rankhands[i]
      for j = #rankhands[i], 1, -1
        sum += rankhands[i][j].bid * a
        a += 1

  print sum

e!

order = {
  "A": 1,
  "K": 2,
  "Q": 3,
  "T": 4,
  "9": 5,
  "8": 6,
  "7": 7,
  "6": 8,
  "5": 9,
  "4": 10,
  "3": 11,
  "2": 12,
  "J": 13,
}

e!
