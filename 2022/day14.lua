local SAND="o"
local WALL="#"

function sleep(n)
  local s=os.clock()
  while (os.clock()-s)<n do end
end

local map={}
local minx, miny = math.huge, 0
local maxx, maxy = -math.huge, -math.huge

function put()
  io.write"\027[2J"
  io.write"\027[0;0H"
  local margin=0
  for y = miny-margin, maxy+margin do
    for x = minx-margin, maxx+margin do
      io.write((map[y] and map[y][x]) or ".")
    end
    print""
  end
end

for l in io.popen"xclip -se c -o":lines() do
  local cx, cy
  for x, y in l:gmatch"(%d+),(%d+)" do
    x,y=tonumber(x),tonumber(y)

    minx=math.min(minx,x)
    miny=math.min(miny,y)
    maxx=math.max(maxx,x)
    maxy=math.max(maxy,y)

    if cx and cy then
      for iy = math.min(y,cy),math.max(y,cy) do
        map[iy]=map[iy]or{}
        for ix = math.min(x,cx),math.max(x,cx) do
          map[iy][ix]=WALL
        end
      end
    end
    cx, cy = x, y
  end
end

local function drop(x,y)
  local function iter()
    if map[y+1] and map[y+1][x] then
        if not (map[y+1] and map[y+1][x-1]) then
          x=x-1
          y=y+1
          if not iter() then return false end
        elseif not (map[y+1] and map[y+1][x+1]) then
          x=x+1
          y=y+1
          if not iter() then return false end
        end
        return true
    end
    return false
  end

  local by=y
  while y <= maxy do
    if iter() then
      map[y]=map[y]or{}
      io.write("\027[".. tostring(y-miny) ..";"..tostring(x-minx).."H")
      io.write"o"
      io.flush()
      map[y][x]=SAND
      break
    end
    y=y+1
  end
  if y == by then return true end
  if y >= maxy then return true end
end

for i = 1, math.huge do
  if i == 1 then put() end
  if drop(500,0) then p1=i-1 break end
  sleep(0.01)
end

sleep(3)

maxy=maxy+2

map[maxy]={}
for x=500-(maxy),500+maxy do
  map[maxy][x]=WALL
  minx,maxx=math.min(minx,x),math.max(maxx,x)
end

for i = 1, math.huge do
  if i == 1 then put() end
  if drop(500,0) then p2=p1+i break end
  sleep(0.001)
end

io.write("\027[".. tostring(maxy-miny+4) ..";0H")

print(p1)
print(p2)
