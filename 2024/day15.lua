local map, moves = io.open"day15.txt":read"*a":match"^(#.+#)\n\n([<>%^v\n]+)$"

moves=moves:gsub("\n", "")
assert(not moves:find("[^<>%^v]"))

local m = {}
local w,h=0,0
local px,py
local px2,py2
for l in map:gmatch"[^\n]+" do
  w=0
  h=h+1
  local r = {}
  table.insert(m,r)
  for c in l:gmatch"." do
    w=w+1
    table.insert(r, c)
    if c == "@" then px,py=w,h px2,py2=w*2-1,h end
  end
end
local m2={}
for y=1,h do
  m2[y]={}
  for x=w,1,-1 do
    local a={["#"]="#",["."]=".",["O"]="[",["@"]="@"}
    local b={["#"]="#",["."]=".",["O"]="]",["@"]="."}
    m2[y][x*2-1]=a[m[y][x]]
    m2[y][x*2]=b[m[y][x]]
  end
end
local function printmap()
  for y = 1, h do
    for x = 1, w do
      io.write(m[y][x])
    end
    print""
  end
end

local dirs = {[">"]={1,0},["<"]={-1,0},["v"]={0,1},["^"]={0,-1}}

for move in moves:gmatch"." do
  local dir = dirs[move]
  local nx,ny=px+dir[1],py+dir[2]
  local mc = m[ny][nx]
  if mc == "." then
    m[ny][nx],m[py][px]="@","."
    px,py=nx,ny
  elseif mc == "O" then
    local nnx,nny=nx,ny
    while true do
      nnx,nny=nnx+dir[1],nny+dir[2]
      local mnn = m[nny][nnx]
      if mnn == "#" then
        break
      elseif mnn == "." then
        m[ny][nx],m[py][px]="@","."
        m[nny][nnx]="O"
        px,py=nx,ny
        break
      end
    end
  end
end

local sum = 0
for y=1,h do
  for x=1,w do
    if m[y][x] == "O" then
      sum=sum+(y-1)*100+(x-1)
    end
  end
end
print(sum)

m=m2
w=w*2
px,py=px2,py2

local function canh(nx, ny, dir, n)
  local c = m[ny][nx]
  if c == "." then return n end
  if c == "#" then return nil end
  if c == "[" or c == "]" then
    return canh(nx+dir*2, ny, dir, n+dir*2)
  end
end

local function moveh(nx, ny, dir, n)
  for x=nx+n, nx, -dir do
    m[ny][x]=m[ny][x-dir]
  end
end

local function canv(nx, ny, dir)
  local c = m[ny][nx]
  local ox
  if c == "." then return true end
  if c == "#" then return false end
  if c == "[" then ox = nx+1 end
  if c == "]" then ox = nx-1 end
  return canv(nx, ny+dir, dir)
     and canv(ox, ny+dir, dir)
end

local function movev(nx,ny,dir,p)
  local c1 = m[ny][nx]
  if c1 == "." then m[ny][nx] = p return end
  local ox
  if c1 == "[" then ox=nx+1 end
  if c1 == "]" then ox=nx-1 end
  local c2 = m[ny][ox]
  m[ny][nx]=p
  m[ny][ox]="."
  movev(nx,ny+dir,dir,c1)
  movev(ox,ny+dir,dir,c2)
end

for move in moves:gmatch"." do
  local dir = dirs[move]
  local nx,ny=px+dir[1],py+dir[2]
  local mc = m[ny][nx]
  if mc == "." then
    m[ny][nx],m[py][px]="@","."
    px,py=nx,ny
  elseif mc == "[" or mc == "]" then
    if dir[1] ~= 0 then
      local n = canh(nx, ny, dir[1], 0)
      if n then
        moveh(nx, ny, dir[1], n)
        m[ny][nx],m[py][px]="@","."
        px,py=nx,ny
      end
    else
      if canv(nx, ny, dir[2]) then
        movev(nx, ny, dir[2], "@")
        m[ny][nx],m[py][px]="@","."
        px,py=nx,ny
      else
      end
    end
  end
end
sum = 0
for y=1,h do
  for x=1,w do
    if m[y][x] == "[" then
      sum=sum+(y-1)*100+(x-1)
    end
  end
end
print(sum)
