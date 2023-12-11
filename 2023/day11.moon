require"moon.all"

grid = {}
for line in io.open"day11.txt"\lines!
  row = [c for c in line\gmatch"."]
  table.insert grid, row
  if line\match"^%.+$"
    table.insert grid, [c for c in *row]

for ci = #grid[1], 1, -1
  dup = true
  for ri = 1, #grid
    if grid[ri][ci] ~= "."
      dup = false
  if dup
    for ri = 1, #grid
      table.insert grid[ri], ci, "."


--for row in *grid
--  for col in *row
--    io.write(col)
--  print""

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
    not @min

  -- O(?) get
  get: =>
    if not @min
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

gal = {}

for y = 1, #grid
  for x = 1, #grid[y]
    if grid[y][x] == "#"
      --gal["#{x};#{y}"] = true
      table.insert gal, {x, y}

nbs = (x, y) ->
  if not y
    x,y = x[1],x[2]
  [{xx, yy} for {xx, yy} in *{{x-1,y},{x+1,y},{x,y-1},{x,y+1}} when 1 <= xx and xx <= #grid[1] and 1 <= yy and yy <= #grid]

ii = (x, y) ->
  if not y
    x,y = x[1],x[2]
  "#{x};#{y}"

heuristic = (a, b) ->
  math.abs(a[1] - b[1]) + math.abs(a[2] - b[2])

dist = (start, goal) ->
  frontier = IntPrioQueue!
  frontier\put(start, 0)

  reached = {}
  came_from = {}
  cost_so_far = {}
  cost_so_far[ii start] = 0


  while not frontier\empty!
    current = frontier\get!
    if ii(current) == ii(goal)
      break

    for nxt in *nbs(current)
      new_cost = cost_so_far[ii current] + 1
      if not cost_so_far[ii nxt] or new_cost < cost_so_far[ii nxt]
        cost_so_far[ii nxt] = new_cost
        prio = new_cost + heuristic(goal, nxt)
        frontier\put nxt, prio
        came_from[ii nxt] = current
  cost_so_far[ii goal]


sum=0
for i = 1, #gal
  for j = i+1, #gal
    sum+=dist(gal[i], gal[j])

print sum
