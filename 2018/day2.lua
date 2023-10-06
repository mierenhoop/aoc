tt = 0
ttt = 0

for l in io.open"day2.txt":read"*a":gmatch"%g+" do
  c = {}
  for i = 1, #l do
    local b = l:byte(i)
    c[b] = (c[b] or 0) + 1
  end

  local two, trh
  for k, v in pairs(c) do
    if v == 2 then
      two = true
    elseif v == 3 then
      trh = true
    end
  end
  if two then tt = tt + 1 end
  if trh then ttt = ttt + 1 end
end

print(tt * ttt)

function diff(a, b)
  local n = 0
  for i = 1, #a do
    if a:byte(i) ~= b:byte(i) then n = n + 1 if n > 1 then return -1 end end
  end
  return n
end

ls = {}
for l in io.open"day2.txt":read"*a":gmatch"%g+" do
  ls[#ls+1] = l
end

for i = 1, #ls do
  for j = i+1, #ls do
    if diff(ls[i], ls[j]) == 1 then
      for k = 1, #ls[i] do
        if ls[i]:byte(k) == ls[j]:byte(k) then
          io.write(ls[i]:sub(k,k))
        end
      end
    end
  end
end
print""
