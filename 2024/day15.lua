local map, moves = io.read"*a":match"^(#.+#)\n\n([<>%^v\n]+)$"

moves=moves:gsub("\n", "")
assert(not moves:find("[^<>%^v]"))

local m = {}
local w,h=0,0
local px,py
for l in map:gmatch"[^\n]+" do
  w=0
  h=h+1
  local r = {}
  table.insert(m,r)
  for c in l:gmatch"." do
    w=w+1
    table.insert(r, c)
    if c == "@" then px,py=w,h end
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

printmap()
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
  --printmap()
end
printmap()

local sum = 0
for y=1,h do
  for x=1,w do
    if m[y][x] == "O" then
      sum=sum+(y-1)*100+(x-1)
    end
  end
end
print(sum)
