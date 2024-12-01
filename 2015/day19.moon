inp = io.open"day19.txt"\read"*a"

--a = "HOHOHO"
--
--repl = [[
--H => HO
--H => OH
--O => HH]]

a = inp\match"(%w+)%s*$"
repl = inp

oo = {}

for k, v in repl\gmatch"(%w+) => (%w+)"
  oo[k] or= {}
  table.insert oo[k], v

all={}
for i = 1, #a
  c = a\sub(i,i)
  if c\lower! == c then continue

  c = a\match("([A-Z][a-z]?)", i)

  if not oo[c] then continue
  for rep in *oo[c]
    all[a\sub(1,i-1)..rep..a\sub(i+#c)] = true


s = 0
s += 1 for _ in pairs all

print s

uu = {}
for k, v in pairs oo
  for ii in *v
    uu[ii] or= {}
    table.insert uu[ii], k

--pp = [l for l in a\gmatch"[A-Ze][a-z]?"]

class IntPrioQueue
  new: =>
    @t = {}

  -- O(1) add
  put: (v, score) =>
    @t[score] or= {}
    table.insert @t[score], v
    if not @min or score < @min
      @min = score
    if not @max or score > @max
      @max = score

  empty: =>
    not @max

  -- O(?) get
  get: =>
    if not @min or not @max
      return
    ret = table.remove @t[@min]
    if #@t[@min] == 0
      for i = @min+1, @max
        if @t[i] and #@t[i] > 0
          @min = i
          break
      if #@t[@max] == 0
        @min, @max = nil, nil
    ret

--min=math.huge
--itr = (s, i) ->
--  if s == "e "
--    min=math.min(min,i)
--    return
--  if seen[s]
--    print seen[s], i
--  seen[s]=i
--
--  for u, v in pairs uu
--    if i == 0
--      print u
--    b, e = s\find "("..u..")[^a-z]"
--    if not b or not e then continue
--    for vv in *v
--      n = s\sub(1,b-1)..vv..s\sub(e)
--      itr n, i+1
--
--itr a.." ", 0

goal = "e "
frontier = IntPrioQueue!
a..=" "
frontier\put(a, 0)
came_from = {}
cost_so_far = {}
cost_so_far[a] = 0
while not frontier\empty!
  current = frontier\get!
  if current == goal
    break

  for u, v in pairs uu
    b, e = current\find "("..u..")[^a-z]"
    if not b or not e then continue
    for vv in *v
      n = current\sub(1,b-1)..vv..current\sub(e)
      new_cost = cost_so_far[current] + 1
      if not cost_so_far[n] or new_cost < cost_so_far[n]
        cost_so_far[n] = new_cost
        priority = new_cost + #n-2
        frontier\put(n, priority)
        came_from[n] = current

print cost_so_far["e "]
