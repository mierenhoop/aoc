input=io.open"day3.txt":read"*a"
n=0
t={}


for l in input:gmatch"%g+" do
  local a, b = l:sub(1,#l/2),l:sub(#l/2+1)
  local m = {}
  for i = 1, #a do
    m[a:byte(i)] = true
  end
  local m2 = {}
  for i = 1, #b do
    m2[b:byte(i)] = true
  end
  for k in pairs(m) do
    if not m2[k] then m[k] = nil end
  end
  for k, v in pairs(m) do s=k - string.byte("a") + 1 
    if s < 0 then s = s + 58 end
    n=n+s
  end
end
print(n)
n=0

for a, b, c in input:gmatch"(%g+)\n(%g+)\n(%g+)" do
  local m = {}
  for i = 1, #a do
    m[a:byte(i)] = true
  end
  local m2 = {}
  for i = 1, #b do
    m2[b:byte(i)] = true
  end
  local m3 = {}
  for i = 1, #c do
    m3[c:byte(i)] = true
  end
  for k in pairs(m) do
    if not m2[k] or not m3[k] then m[k] = nil end
  end
  for k, v in pairs(m) do s=k - string.byte("a") + 1 
    if s < 0 then s = s + 58 end
    n=n+s
  end
end

print(n)
