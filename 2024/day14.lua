local mx,my=0,0
local bots={}
for l in io.open"day14.txt":lines() do
  local px,py,vx,vy=l:match"p=(%d+),(%d+) v=(%-?%d+),(%-?%d+)"
  assert(px)
  px,py,vx,vy=tonumber(px),tonumber(py),tonumber(vx),tonumber(vy)
  mx=math.max(mx,px)
  my=math.max(my,py)
  table.insert(bots,{p={px,py},v={vx,vy}})
end
local quads={0,0,0,0}
for _, b in ipairs(bots) do
  local x =(b.p[1]+100*b.v[1])%(mx+1)
  local y =(b.p[2]+100*b.v[2])%(my+1)
  local q
  if x < mx/2 and y < my/2 then q=1 end
  if x > mx/2 and y < my/2 then q=2 end
  if x < mx/2 and y > my/2 then q=3 end
  if x > mx/2 and y > my/2 then q=4 end
  if q then quads[q]=quads[q]+1 end
end
local sum = 1
for q=1,4 do
  sum=sum*quads[q]
end
print(sum)

local i = 0
while true do
  local m = {}
  for _, b in ipairs(bots) do
    local x =(b.p[1]+i*b.v[1])%(mx+1)
    local y =(b.p[2]+i*b.v[2])%(my+1)
    m[y]=m[y]or{}
    m[y][x]=(m[y][x] or 0)+1
  end
  local a=0
  for x=0,mx do
    if m[42] and m[42][x] then a=a+1 end
    if m[74] and m[74][x] then a=a+1 end
  end
  if a > 60 then
    for y = 0, my do
      for x = 0, mx do
        io.write((m[y] and m[y][x] and m[y][x] > 0) and "#" or ".")
      end
      print""
    end
    print(i)
    break
  end
  i=i+1
end
