local mx,my=0,0
local bots={}
for l in io.lines() do
  local px,py,vx,vy=l:match"p=(%d+),(%d+) v=(%-?%d+),(%-?%d+)"
  assert(px)
  px,py,vx,vy=tonumber(px),tonumber(py),tonumber(vx),tonumber(vy)
  mx=math.max(mx,px)
  my=math.max(my,py)
  table.insert(bots,{p={px,py},v={vx,vy}})
end

local quads={0,0,0,0}
for _, b in ipairs(bots) do
  local x =b.p[1]+100*b.v[1]
  local y =b.p[2]+100*b.v[2]
  x=x%(mx+1)
  y=y%(my+1)
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

