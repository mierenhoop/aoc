map={}

function set(x, y, id)
  map[y] = map[y] or {}
  if map[y][x] then
    if map[y][x] ~= 0 then
      map[y][x] = 0
      return true
    end
  else
    map[y][x] = id
  end
end

i=0
for id, x, y, w, h in io.open"day3.txt":read"*a":gmatch"#(%d+) @ (%d+),(%d+): (%d+)x(%d+)" do
  for yy = y, y + h-1 do
    for xx = x, x + w-1 do
      if set(xx, yy, id) then
        i=i+1
      end
    end
  end
end

print(i)

i=0
for id, x, y, w, h in io.open"day3.txt":read"*a":gmatch"#(%d+) @ (%d+),(%d+): (%d+)x(%d+)" do
  for yy = y, y + h-1 do
    for xx = x, x + w-1 do
      if map[yy][xx] ~= id then
        goto nxt
      end
    end
  end
  print(id)
  break
  ::nxt::
end
