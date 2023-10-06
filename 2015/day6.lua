local li = {}
local li2 = {}

local tn=tonumber
for l in io.open("day6.txt", "r"):lines() do
  local meth, x1, y1, x2, y2 = l:match"(%w+) (%d+),(%d+) through (%d+),(%d+)"
  x1,y1,x2,y2=tn(x1),tn(y1),tn(x2),tn(y2)

  for i = x1,x2 do
    li[i] = li[i] or {}
    li2[i] = li2[i] or {}
    for j = y1,y2 do
      local b=li[i][j]
      li[i][j] = ({toggle=not b,on=true,off=false})[meth]

      b=li2[i][j] or 0
      li2[i][j] = math.max(b+({toggle=2,on=1,off=-1})[meth], 0)
    end
  end
end

local v = 0
local v2 = 0
for i = 0, 1000 do
  for j = 0,1000 do
    if li[i] and li[i][j] then v = v + 1 end
    if li2[i] then v2 = v2 + (li2[i][j] or 0) end
  end
end
print(v)
print(v2)
