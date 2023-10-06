local s = io.open("day6.txt"):read("*a")
local function find(n)
  for i = n, #s do
    local t = {}
    local chars = {s:byte(i - n + 1, i)}
    for j = 1, #chars do t[chars[j]] = 1 end
    local sum = 0
    for _ in pairs(t) do
      sum = sum + 1
    end
    if sum == n then
      return i
    end
  end
end
print(find(4))
print(find(14))
