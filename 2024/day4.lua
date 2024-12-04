local s = "XMAS"
local t = {}
for line in io.open"day4.txt":read"*a":gmatch"[^\n]+" do
  table.insert(t, line)
end

local function get(x, y)
  if y < 1 or y > #t then return nil end
  if x < 1 or x > #t[y] then return nil end
  return t[y]:sub(x,x)
end
local function check(i, x, y, dx, dy)
  if i > #s then return true end
  local c = get(x, y)
  if not c then return false end
  if c ~= s:sub(i,i) then
    return false
  end
  return check(i + 1, x+dx, y+dy, dx, dy)
end

local function iscorner(c)
  return c == "M" or c == "S"
end

local function check2(x, y)
  if get(x, y) ~= "A" then
    return false
  end
  local c = {get(x-1,y-1),get(x+1,y-1),get(x-1,y+1),get(x+1,y+1)}
  for i = 1, 4 do if not iscorner(c[i]) then return false end end
  if (c[1]==c[2] and c[3]==c[4] and c[1]~=c[3]) or (c[1]==c[3] and c[2]==c[4] and c[1]~=c[4]) then return true end
end

local sum = 0
local sum2 = 0
for y = 1, #t do
  for x = 1, #t[y] do
    if check2(x, y) then
      sum2 = sum2 + 1
    end
    for dy = -1, 1 do
      for dx = -1, 1 do
        if dx ~= 0 or dy ~= 0 then
          if check(1, x, y, dx, dy) then
            sum = sum + 1
          end
        end
      end
    end
  end
end
print(sum)
print(sum2)
