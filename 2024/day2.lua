local function check(t, skip)
  local ok = true
  local isdesc = nil
  for i = 2, #t do
    if i ~= skip and not (skip == 1 and i == 2)then
      local d = t[i] - t[i-1]
      if i-1 == skip then d = t[i] - t[i-2] end
      if d == 0 or math.abs(d) > 3 then ok = false break end
      if isdesc == nil then
        isdesc = d < 0
      elseif (isdesc == false and d < 0) or (isdesc == true and d > 0)  then
        ok = false break
      end
    end
  end
  return ok
end

local sum = 0
local skipsum = 0
for line in io.open"day2.txt":read"*a":gmatch"[^\n]+" do
  local t = {}
  for i in line:gmatch"%d+" do
    table.insert(t, tonumber(i))
  end
  local ok = false
  for i = 0, #t do
    ok = check(t, i)
    if i == 0 and ok then
      sum = sum + 1
    end
    if ok then
      break
    end
  end
  if ok then
    skipsum = skipsum + 1
  end
end
print(sum)
print(skipsum)
