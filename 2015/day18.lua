
local map = {}
local m2 = {}
for l in io.open("day18.txt","r"):lines() do
  map[#map+1]={}
  m2[#m2+1]={}
  for c in l:gmatch"." do
    table.insert(map[#map], c=="#")
    table.insert(m2[#m2], c=="#")
  end
end

local function iter()
  local n = {[0]={},{}}
  local function br(i,j) n[i][j] = (n[i][j] or 0) + 1 end
  for i = 1, #map do
    n[i+1] = {}
    for j = 1, #map[i] do
      if map[i][j] then
        br(i-1,j-1)
        br(i-1,j)
        br(i-1,j+1)
        br(i,j-1)
        br(i,j+1)
        br(i+1,j-1)
        br(i+1,j)
        br(i+1,j+1)
      end
    end
  end
  for i = 1, #map do
    for j = 1, #map[i] do
      if map[i][j] then
        if n[i][j] ~= 2 and n[i][j] ~= 3 then map[i][j] = false end
      else
        if n[i][j] == 3 then map[i][j] = true end
      end
    end
  end
end


local function iter2()
  m2[1][1],m2[1][#m2[1]],m2[#m2][#m2[1]],m2[#m2][1]=true,true,true,true
  local n = {[0]={},{}}
  local function br(i,j) n[i][j] = (n[i][j] or 0) + 1 end
  for i = 1, #m2 do
    n[i+1] = {}
    for j = 1, #m2[i] do
      if m2[i][j] then
        br(i-1,j-1)
        br(i-1,j)
        br(i-1,j+1)
        br(i,j-1)
        br(i,j+1)
        br(i+1,j-1)
        br(i+1,j)
        br(i+1,j+1)
      end
    end
  end
  for i = 1, #m2 do
    for j = 1, #m2[i] do
      if m2[i][j] then
        if n[i][j] ~= 2 and n[i][j] ~= 3 then m2[i][j] = false end
      else
        if n[i][j] == 3 then m2[i][j] = true end
      end
    end
  end
end

for i = 1, 100 do
  iter()
  iter2()
end
local sum=0
for _, v in ipairs(map) do for _, n in ipairs(v) do sum = sum+(n and 1 or 0) end end
print(sum)

m2[1][1],m2[1][#m2[1]],m2[#m2][#m2[1]],m2[#m2][1]=true,true,true,true
sum=0
for _, v in ipairs(m2) do for _, n in ipairs(v) do sum = sum+(n and 1 or 0) end end
print(sum)