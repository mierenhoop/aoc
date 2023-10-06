local input = io.open"day9.txt"

local m1 = {}
local m2 = {}

local k = {}
for i = 0, 9 do
  k[i]={0,0}
end

local function updatetails()
  for i = 1, 9 do
    local c = k[i]
    local p = k[i-1]
    local dx, dy = p[1]-c[1], p[2]-c[2]
    if math.abs(dx) > 1 or math.abs(dy) > 1 then
      c[1] = c[1] + math.min(math.max(dx,-1),1)
      c[2] = c[2] + math.min(math.max(dy,-1),1)
    end
  end
  m1[k[9][1]..","..k[9][2]]=1
  m2[k[1][1]..","..k[1][2]]=1
end

for dir,n in input:read"*a":gmatch"([LRUD]) (%d+)" do
  n=tonumber(n)
  diff=({
    L={-1,0},
    R={1,0},
    U={0,-1},
    D={0,1},
  })[dir]
  for i = 1, n do
    k[0][1]=k[0][1]+diff[1]
    k[0][2]=k[0][2]+diff[2]
    updatetails()
  end
end

n=0
for _ in pairs(m2) do
  n=n+1
end
print(n)
n=0
for _ in pairs(m1) do
  n=n+1
end
print(n)
