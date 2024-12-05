local input = io.open"day5.txt":read"*a"

local first, second = input:match"^(.-)\n\n(.+)$"

local l = {}
local r = {}
for a, b in first:gmatch"(%d+)|(%d+)" do
  a = tonumber(a)
  b = tonumber(b)
  r[b] = r[b] or {}
  r[b][a] = true
  l[a] = l[a] or {}
  l[a][b] = true
end

local sum = 0
local sum2 = 0
for line in second:gmatch"[^\n]+" do
  local ok = true
  local tt = {}
  for v in line:gmatch"%d+" do
    v = tonumber(v)
    table.insert(tt, v)
  end
  local isok = true
  for i = #tt, 1, -1 do
    for j = i-1,1,-1 do
      if not r[tt[i]] or not r[tt[i]][tt[j]] then
        isok = false
        tt[i], tt[j] = tt[j], tt[i]
      end
    end
  end
  if isok then
    sum = sum + (tt[#tt//2+1])
  else
    sum2 = sum2 + (tt[#tt//2+1])

  end
end
print(sum)
print(sum2)
