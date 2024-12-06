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

local seen = {}

while 1 <= pos[1] and pos[1] <= #t[1] and 1 <= pos[2] and pos[2] <= #t do
  local nextpos = {pos[1]+dir[1], pos[2]+dir[2]}
  if t[nextpos[2]] and t[nextpos[2]][nextpos[1]] == "#" then
    dc = succ[dc]
    dir = dirs[dc]
  else
    seen[pos[1]..","..pos[2]] = true
    pos = nextpos
  end
end
local sum = 0
for k in pairs(seen) do
  sum = sum + 1
end
print(sum)
