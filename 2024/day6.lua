local t = {}
local pos = {}
local dirs = {[">"]={1,0},["<"]={-1,0},["v"]={0,1},["^"]={0,-1}}
local succ = {[">"]="v",["<"]="^",["v"]="<",["^"]=">"}
local dc
local dir
local y = 1
for l in io.open"day6.txt":lines() do
  local x = 1
  local r = {}
  table.insert(t, r)
  for c in l:gmatch"." do
    if dirs[c] then
      assert(not dir)
      dc = c
      dir = dirs[dc]
      pos={x, y}
    end
    table.insert(r, c)
    x=x+1
  end
  y=y+1
end
local start = pos
local startdir = dir
local startdc = dc

local seen = {}

while 1 <= pos[1] and pos[1] <= #t[1] and 1 <= pos[2] and pos[2] <= #t do
  local nextpos = {pos[1]+dir[1], pos[2]+dir[2]}
  if t[nextpos[2]] and t[nextpos[2]][nextpos[1]] == "#" then
    dc = succ[dc]
    dir = dirs[dc]
  else
    local k = pos[1]..","..pos[2]
    seen[k] = seen[k] or {}
    seen[k][dc] = 1
    pos = nextpos
  end
end
local sum = 0
for k in pairs(seen) do
  sum=sum+1
end
print(sum)
local sum2 = 0
for k in pairs(seen) do
  local x, y = k:match"(%d+),(%d+)"
  x=tonumber(x)
  y=tonumber(y)
  pos = {start[1],start[2]}
  dir = startdir
  dc = startdc
  local loop = {}
  local newseen = {}
  while 1 <= pos[1] and pos[1] <= #t[1] and 1 <= pos[2] and pos[2] <= #t do
    pos[1]=pos[1]+dir[1]
    pos[2]=pos[2]+dir[2]
    if (pos[1] == x and pos[2] == y) or (t[pos[2]] and t[pos[2]][pos[1]] == "#") then
      local k = pos[1]..","..pos[2]..dc
      if newseen[k] then
          sum2 = sum2+1
          break
      end
      newseen[k] = true
      pos[1]=pos[1]-dir[1]
      pos[2]=pos[2]-dir[2]
      dc = succ[dc]
      dir = dirs[dc]
    end
  end
end
print(sum2)
