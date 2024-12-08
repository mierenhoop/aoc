local t = {}
local freqs = {}
local y = 1
for l in io.open"day8.txt":lines() do
  local r = {}
  table.insert(t, r)
  local x = 1
  for c in l:gmatch"." do
    table.insert(r, c)
    if c ~= "." then
      freqs[c] = freqs[c] or {}
      table.insert(freqs[c], {x, y})
    end
    x=x+1
  end
  y=y+1
end

local w, h = #t[1], #t
local antis={}
local function add(x,y)
  if 1<=x and x<=w and 1<=y and y <=h then
    antis[x..","..y] = true
  end
end
for f, tt in pairs(freqs) do
  for i = 1, #tt do
    for j = i+1, #tt do
      local dx = tt[i][1]-tt[j][1]
      local dy = tt[i][2]-tt[j][2]
      add(tt[i][1]+dx, tt[i][2]+dy)
      add(tt[j][1]-dx, tt[j][2]-dy)
    end
  end
end
local sum=0
for f in pairs(antis) do
  sum=sum+1
end
print(sum)

antis={}
for f, tt in pairs(freqs) do
  for i = 1, #tt do
    for j = i+1, #tt do
      local dx = tt[i][1]-tt[j][1]
      local dy = tt[i][2]-tt[j][2]
      local xx = tt[i][1]
      local yy = tt[i][2]
      while 1<=xx and xx<=w and 1<=yy and yy<=h do
        xx = xx-dx
        yy = yy-dy
        add(xx,yy)
      end
      xx = tt[j][1]
      yy = tt[j][2]
      while 1<=xx and xx<=w and 1<=yy and yy<=h do
        xx = xx+dx
        yy = yy+dy
        add(xx,yy)
      end
    end
  end
end
sum=0
for f in pairs(antis) do
  sum=sum+1
end
print(sum)


--for yy=1,h do
--  for xx=1,w do
--    io.write(antis[xx..","..yy] and "#" or ".")
--  end
--  print""
--end
