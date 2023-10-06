local primes={}
local primesmap={}

for i = 2,1000 do
  local t
  for j = math.ceil(i/2),1,-1 do
    if math.floor(i/j)==i/j then
      if primesmap[j] then
        t=true
        break
      end
    end
  end
  if not t then
    table.insert(primes,i)
    primesmap[i]=#primes
    print(i)
  end
end

for i = 3, 100 do
  local highest
  for j = math.ceil(i/2),1,-1 do
    if primesmap[j] then highest = primesmap[j] break end
  end
  
  local sum = i

  for j = highest, 1 do
    local prime = primes[j]
    if math.floor(i/prime) == i/prime then
      sum = sum + primesmap[prime]
    end
  end
  print(sum)
end
