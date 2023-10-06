local a = io.open("day3.txt","r"):read"*a"

local i = 1
local x, y = 0,0
local done = {["0,0"]=true}
for c in a:gmatch"." do
  if c == "<" then
    x = x - 1
  elseif c == ">" then
    x = x + 1
  elseif c == "^" then
    y = y - 1
  elseif c == "v" then
    y = y + 1
  end
  if not done[x..","..y] then
    done[x..","..y] = true
    i = i + 1
  end
end
print(i)

i=1
local x2, y2 = 0,0
local x1, y1 = 0,0
done = {["0,0"]=true}
local ctr = 0
for c in a:gmatch"." do
  ctr = (ctr + 1) % 2
  local x, y=0,0
  if c == "<" then
    x = 1
  elseif c == ">" then
    x = -1
  elseif c == "^" then
    y = -1
  elseif c == "v" then
    y = 1
  end
  if ctr == 0 then
    x1=x1+x
    y1=y1+y
  else
    x2=x2+x
    y2=y2+y
  end
  if not done[x1..","..y1] then done[x1..","..y1] = true i = i + 1 end
  if not done[x2..","..y2] then done[x2..","..y2] = true i = i + 1 end
end
print(i)