local function summul(s)
  local sum = 0
  for x, y in s:gmatch"mul%((%d%d?%d?),(%d%d?%d?)%)" do
    sum = sum + tonumber(x) * tonumber(y)
  end
  return sum
end
local input = io.open"day3.txt":read"*a"
print(summul(input))
local sum = 0
input = "do()"..input.."don't()"
for block in input:gmatch"do%(%)(.-)don't%(%)" do
  sum = sum + summul(block)
end
print(sum)
