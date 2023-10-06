local i = 0
local floor = 0
local index
for c in io.open("day1.txt","r"):read"*a":gmatch"[%(%)]" do
  if c == "(" then floor = floor + 1
  elseif c == ")" then floor = floor - 1 end
  i = i + 1
  if floor == -1 and not index then index = i end
end

print(floor)
print(index)