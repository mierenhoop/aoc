local line = io.open"day9.txt":read"*l"
local x = 1
local t = {}
local tt={}
local id=0
for n, free in line:gmatch"(%d)(%d?)" do
  n=tonumber(n)
  free=tonumber(free) or 0
  for i = 1,n do
    t[x]=id
    tt[x]=id
    x=x+1
  end
  for i = 1,free do
    x=x+1
  end
  id=id+1
end
local mx=x
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
x=mx
t=tt
while x>1 do
  if t[x] then
    local v = t[x]
    local i = 0
    while t[x] == v do
      i=i+1
      x=x-1
    end
    local free=0
    for b=1,x do
      if t[b] then
        free=0
      else
        free=free+1
        if free==i then
          for l=1,i do
            t[b-i+l],t[x+l]=t[x+l],nil
          end
        end
      end
    end
  else
    x=x-1
  end
end
sum = 0
for i = 1, mx do
  sum=sum+(i-1)*(t[i] or 0)
end
print(sum)
