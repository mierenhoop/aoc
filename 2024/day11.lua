-- only works with luajit for 64 bit numbers

local tt = {}
for n in io.open"day11.txt":read"*a":gmatch"%d+" do
  tt[n]=(tt[n]or 0)+1
end

local function run(l)
  local t = tt
  for i = 1, l do
    local newt = {}
    for v, n in pairs(t) do
      local a,b
      if #v % 2 == 0 then
        a=v:sub(1,#v/2)
        b= tostring(tonumber(v:sub(#v/2+1)))
      elseif v == "0" then
        a="1"
      else
        a = tostring(tonumber(v)*2024)
      end
      if a then newt[a]=(newt[a] or 0ULL)+n end
      if b then newt[b]=(newt[b] or 0ULL)+n end
    end
    t=newt
  end
  local sum = 0
  for k, v in pairs(t) do
    sum=sum+v
  end
  return sum
end

print(tostring(run(25)):sub(1,-4))
print(tostring(run(75)):sub(1,-4))
