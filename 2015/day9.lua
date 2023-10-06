
local trvl = {}

for l in io.open("day9.txt","r"):lines() do
  local from, to, d = l:match"(%g+) to (%g+) = (%d+)"
  trvl[from] = trvl[from] or {}
  trvl[from][to] = d

  trvl[to] = trvl[to] or {}
  trvl[to][from] = d
end

local l = 0
for _ in pairs(trvl) do
  l = l + 1
end

local lowest = math.huge
local longest = 0

function iter(road, tos, dis)
  for to, d in pairs(tos) do
    local dn = {} 
    for i = 1, #road do
      if road[i] == to then goto nxt end
      dn[i]=road[i]
    end
    dn[#dn+1]=to

    if #dn == l then
      if dis + d < lowest then lowest = dis + d end
      if dis + d > longest then longest = dis + d end
      return
    end

    iter(dn, trvl[to], dis + d)
    ::nxt::
  end
end

for from, tos in pairs(trvl) do
  local road = {from}

  iter(road, tos, 0)
end

print(math.floor(lowest))
print(math.floor(longest))
