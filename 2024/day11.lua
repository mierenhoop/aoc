local m ={}
local function iter(n, i)
  m[i]=m[i]or{}
  table.insert(m[i],n)
  if i < 1 then
    return 1
  end
  if #n == 1 and n == "0" then return iter("1", i-1) end
  if #n % 2 == 0 then
    return iter(n:sub(1,#n/2),i-1)+iter(tostring(tonumber(n:sub(#n/2+1))),i-1)
  else
    n = tostring(tonumber(n)*2024)
    return iter(n, i-1)
  end
end


local sum = 0
for n in io.open"day11.txt":read"*a":gmatch"%d+" do
  sum=sum+iter(n, 25)
end
print(sum)

--for i=6,1,-1 do
--  for i,v in ipairs(m[i]) do
--    io.write(v.." ")
--  end
--  print""
--end
