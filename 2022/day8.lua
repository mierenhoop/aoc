map={}
for l in io.open"day8.txt":lines() do
  map[#map+1]={}
  for c in l:gmatch"." do
    c=tonumber(c)
    table.insert(map[#map], c)
  end
end

function visible(y, x)
  local h = map[y][x]
  for i = 1, y-1 do
    if map[i][x] >= h then goto n1 end
  end
  do return true end
  ::n1::
  for i = #map, y+1,-1 do
    if map[i][x] >= h then goto n2 end
  end
  do return true end
  ::n2::
  for i = 1, x-1 do
    if map[y][i] >= h then goto n3 end
  end
  do return true end
  ::n3::
  for i = #map[y], x+1,-1 do
    if map[y][i] >= h then return false end
  end
  return true
end

function fromtree(y, x)
  local h = map[y][x]
  local n1,n2,n3,n4 = 0,0,0,0
  for i = y-1, 1,-1 do
    n1=n1+1
    if map[i][x] >= h then break end
  end
  for i = y+1, #map do
    n2=n2+1
    if map[i][x] >= h then break end
  end
  for i = x-1,1,-1 do
    n3=n3+1
    if map[y][i] >= h then break end
  end
  for i = x+1,#map[y] do
    n4=n4+1
    if map[y][i] >= h then break end
  end
  return n1*n2*n3*n4
end

cnt=0
sc=0
for y, rows in ipairs(map) do
  for x, col in ipairs(rows) do
    if visible(y, x) then cnt=cnt+1 end
    if fromtree(y,x) > sc then
      sc=fromtree(y,x)
    end
  end
end
print(cnt)
print(sc)
