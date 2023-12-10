require"moon.all"

--map = for line in io.open"day10.txt"\lines!
--  [col for col in line\gmatch"."]
--
--animal = nil
--for y, row in ipairs map
--  for x, col in ipairs row
--    if col == "S"
--      animal = {x, y}
--
--pipemap = {
--  "1;0": {"-", "J", "7"},
--  "-1;0": {"-", "L", "F"},
--  "0;1": {"|", "L", "J"},
--  "0;-1": {"|", "7", "F"},
--}
--
--edges = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
--
--nxt = (animal, prev) ->
--  for {x, y} in *edges
--    nx, ny = animal[1]+x, animal[2]+y
--    if nx < 1 or #map[1] < nx or ny < 1 or #map < ny
--      continue
--    nn = "#{nx};#{ny}"
--    for pipe in *pipemap["#{x};#{y}"]
--      if map[ny][nx] == pipe and pipe ~= prev
--        print pipe
--        return nxt({nx, ny}, pipe)
--
--nxt animal


input = io.open"day10.txt"\read"*a"
w = input\find"\n" - 1
input = input\gsub "%s", ""
map = {x-1, input\sub(x,x) for x = 1, #input}
h = #input/w

animal = nil
for i = 0, w*h-1
  if map[i] == "S"
    animal = i
    break

pipemap = {
  [1]: {"-":1, "J":-w, "7":w},
  [-1]: {"-":-1, "L":-w, "F":w},
  [w]: {"|":w, "L":1, "J":-1},
  [-w]: {"|":-w, "7":-1, "F":1},
}

-- right -> +1, left -> -1
turnmap = {
  [1]: {"J":-1, "7":1},
  [-1]: {"L":1, "F":-1},
  [w]: {"L":-1, "J":1},
  [-w]: {"7":-1, "F":1},
}

turns = 0

path = {}

i=0
iter = (pos, curd) ->
  path[pos] = 1
  for d in *(curd and {curd} or {-w, -1, 1, w})
    nxtpos = pos+d
    nxtpipe = map[nxtpos]
    nxtd = pipemap[d][nxtpipe]
    if nxtd
      turns += turnmap[d][nxtpipe] or 0
      i+=1
      iter nxtpos, nxtd
      break

iter animal

print math.ceil(i/2)
dir = turns > 0 and 1 or -1

dirmap = {
  [1]: {"-": w*dir},
  [-1]: {"-": -w*dir},
  [w]: {"|": -dir},
  [-w]: {"|": dir},
}

reached = {}
search = (start) ->
  frontier = {start}
  if not path[start] and map[start]
    reached[start] = true

    while #frontier > 0
      current = table.remove(frontier)
      for d in *{-w, -1, 1, w}
        nxt = current+d
        if not path[nxt] and map[nxt] and not reached[nxt]
          table.insert frontier, nxt
          reached[nxt] = true
          --print "reached", nxt


iter = (pos, curd) ->
  for d in *(curd and {curd} or {-w, -1, 1, w})
    nxtpos = pos+d
    nxtpipe = map[nxtpos]
    nxtd = pipemap[d][nxtpipe]
    if nxtd
      dd = dirmap[d][nxtpipe]
      if dd
        search nxtpos+dd
        --print nxtpipe, nxtpos+dd
      iter nxtpos, nxtd
      break

iter animal


--for y = 0, h-1
--  for x = 0, w-1
--    io.write(reached[y*w+x] and "#" or ".")
--  print""

--print #[a for a in pairs reached]
