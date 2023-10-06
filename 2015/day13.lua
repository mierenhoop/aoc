
local trvl = {}

for l in io.open("day13.txt","r"):lines() do
  local a, what, amount, b  = l:match"(%g+) would (%g+) (%d+) happiness units by sitting next to (%g+)."
  amount = tonumber(amount)
  if what == "lose" then amount = -amount end
  trvl[a] = trvl[a] or {}
  trvl[a][b] = amount
end

local l = 0
for _ in pairs(trvl) do
  l = l + 1
end

local best = 0

function iter(road, tos)
  for to in pairs(tos) do
    local dn = {} 
    for i = 1, #road do
      if road[i] == to then goto nxt end
      dn[i]=road[i]
    end
    dn[#dn+1]=to

    if #dn == l then
      local happi = 0
      for j = 0, l-1 do
        happi = happi + trvl[dn[j+1]][dn[((j+1)%l)+1]]
                      + trvl[dn[((j+1)%l)+1]][dn[j+1]]
      end
      best = math.max(happi, best)
      return
    end

    iter(dn, trvl[to])
    ::nxt::
  end
end

for from, tos in pairs(trvl) do
  local road = {from}

  iter(road, tos)
end

print(best)
best=0

me="MEEEEEEEEEEEE"
l = l + 1
met={}
for k, v in pairs(trvl) do
  met[k]=0
  v[me]=0
end
trvl[me]=met

for from, tos in pairs(trvl) do
  local road = {from}

  iter(road, tos)
end

print(best)
