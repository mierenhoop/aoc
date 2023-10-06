
local n1, n2, n3 = 0,0,0
for l in io.open("day8.txt", "r"):lines() do
  n1 = n1 + #l
  n2 = n2 + #load("return "..l)()
  n3 = n3 + #string.format("%q", l)
end

print(n1 - n2)
print(n3 - n1)
