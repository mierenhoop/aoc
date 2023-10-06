local ft = 0
local rib = 0

for line in io.open("day2.txt","r"):lines() do
  local a, b, c = line:match"(%d+)x(%d+)x(%d+)"
  local q, r, s = a*b,a*c, b*c
  local x, y, z = a+b, a+c, b+c
  rib = rib + math.min(x,y,z)*2 + a*b*c
  ft = ft + 2*(q+r+s) + math.min(q,r,s)
end

print(ft)
print(rib)