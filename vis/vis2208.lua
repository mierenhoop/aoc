map={}
for l in io.open"2022/day8.txt":lines() do
  map[#map+1]={}
  for c in l:gmatch"." do
    c=tonumber(c)
    table.insert(map[#map], {h=c,ok=false})
  end
end

function maptosc(y, x)
  return y + 1, x + 1
end

local plterm=require"plterm"
io.output():setvbuf("no")
plterm.hide()
plterm.clear()

local function sleep(n)
  local start = os.clock()
  while (os.clock() - start) < n do end
end


for y = 1, #map do
  for x = 1, #map[y] do
    sleep(0.0001)
    plterm.golc(maptosc(y, x))
    io.write(tostring(map[y][x].h))
  end
end

function iter(a,b,c,d,e, f)
  for y = a, b do
    local mh = -1
    for x = c, d,e do
      local x,y=x,y
      if f then x, y = y, x end
      if map[y][x].h <= mh then break end
      plterm.golc(maptosc(y, x))
      plterm.color(plterm.colors.default, plterm.colors.bgcyan)
      io.write(tostring(map[y][x].h))

      map[y][x].ok=true

      mh = math.max(map[y][x].h, mh)
    end
    sleep(0.01)
    local mh = -1
    for x = c, d,e do
      local x,y=x,y
      if f then x, y = y, x end
      if map[y][x].h <= mh then break end
      plterm.golc(maptosc(y, x))
      plterm.color(plterm.colors.default)
      io.write(tostring(map[y][x].h))

      mh = math.max(map[y][x].h, mh)
    end
  end
end

iter(1,#map,1,#map[1],1, false)
iter(1,#map,#map[1],1,-1, false)
iter(1,#map[1],1,#map,1, true)
iter(1,#map[1],#map,1,-1, true)

sleep(3)
plterm.show()
plterm.clear()
plterm.reset()

for _,v in ipairs(map) do
  for _,c in ipairs(v) do if c.ok then a=(a or 0)+1 end end
end

print(a)
