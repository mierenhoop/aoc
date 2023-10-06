function index(c,r)
  return math.floor((c+1)*c/2+(r)*(r-1)/2+(r-1)*(c-1))
end

local r,c = io.open("day25.txt","r"):read"*a":match"row (%d+), column (%d+)"
local i = index(c,r)

local v = 20151125
for k = 1,i-1 do
  v = (v * 252533) % 33554393
end
print(v)