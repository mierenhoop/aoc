local line = io.open"day9.txt":read"*l"
local x = 1
local t = {}
local id=0
for n, free in line:gmatch"(%d)(%d?)" do
  n=tonumber(n)
  free=tonumber(free) or 0
  for i = 1,n do
    t[x]=id
    x=x+1
  end
  for i = 1,free do
    x=x+1
  end
  id=id+1
end
for i = 1, x do
  if not t[i] then
    while x > i and not t[x] do
      x=x-1
    end
    if t[x] then t[i],t[x]=t[x],nil end
  end
end
local sum = 0
for i = 1, #t do
  sum=sum+(i-1)*t[i]
end
print(sum)
