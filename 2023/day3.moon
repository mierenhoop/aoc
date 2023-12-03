require"moon.all"

--input = io.open"day3.txt"\read"*a"
--
--w = input\find "\n"
--
----input = "."\rep(w) .. input .. "."\rep(w)
--
--
--b = 0
--b += n for n in input\gmatch"%d+"
--
--print "b", b
--
--symbols="[^.xy\n0-9]"
--
--while true
--  print"iter"
--  old = input
--  for i in *{w,w-1,w-2,0}
--    input = input\gsub("(%d)(#{'.'\rep i}#{symbols})", "x%2")
--
--  for i in *{w,w-1,w-2,0}
--    input = input\gsub("(#{symbols}#{'.'\rep i})(%d)", "%1y")
--  break if old == input
--
--print input
--
--a = 0
--a += n for n in ("."..input..".")\gmatch"[^xy0-9](%d+)[^xy0-9]"
--
--print n for n in ("."..input..".")\gmatch"[^xy0-9](%d+)[^xy0-9]"
--
--print "a", a
--
--print b - a

grid = {}
for line in io.open"day3.txt"\lines!
  row = {}

  for c in line\gmatch"."
    table.insert row, c

  table.insert grid, row

hastool = (x, y) ->
  for xx=x-1,x+1
    for yy=y-1,y+1
      if grid[yy] and grid[yy][xx] and grid[yy][xx]\match"[^0-9.]"
        return {xx, yy}
  return false

ok = {}

for y, row in ipairs grid
  for x, col in ipairs row
    tool = hastool x, y
    if col\match"%d" and tool
      table.insert ok, {x, y, tool: tool}

norm = {}

gears = {}

-- normalize
for i, {x, y} in ipairs ok
  while x >= 1
    if not grid[y][x]\match"%d"
      break
    x -= 1
  norm[y] or= {}
  norm[y][x+1] = ok[i].tool

nums = {}
nn = 0
for y, row in pairs norm
  for x, {tx, ty} in pairs row
    if grid[ty][tx] == "*"
      idx = "#{tx};#{ty}"
      gears[idx] or= {}
      table.insert gears[idx], {x, y}
    ox = x

    cc = ""
    while true
      c = grid[y][x]
      x+=1
      if not c or not c\match"%d"
        break
      cc ..= c
    nn += tonumber cc
    nums["#{ox};#{y}"] = tonumber cc
print nn

ratios = 0
for _, gs in pairs gears
  if #gs == 2
    n = 1
    for {x, y} in *gs
      n *= nums["#{x};#{y}"]
    ratios += n

print ratios
