local left, right = {}, {}
local amount = {}
for a, b in io.open"day1.txt":read"*a":gmatch"(%d+) +(%d+)" do
  table.insert(left, tonumber(a))
  table.insert(right, tonumber(b))
  b = tonumber(b)
  amount[b] = (amount[b] or 0) + 1
end
table.sort(left)
table.sort(right)
local sum = 0
local score = 0
for i = 1, #left do
  sum = sum + math.abs(left[i] - right[i])
  score = score + (amount[left[i]] or 0) * left[i]
end
print(sum)
print(score)
