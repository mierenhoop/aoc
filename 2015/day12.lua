local l = io.open("day12.txt","r"):read"*a"
n="0"
for v in l:gmatch"%-?%d+" do
  n = n + v
end
print(math.floor(tonumber(n)))

t = load("return "..l:gsub("%[","{"):gsub("%]","}"):gsub('("[^"]+"):','[%1]='))()


function doting(t)
  local this = 0
  for k, v in pairs(t) do
    if type(k) ~= "number" and v == "red" then
      this = 0
      break
    end
    if type(v) == "number" then
      this = this + v
    elseif type(v) == "table" then
      this = this + doting(v)
    end
  end

  return this
end

print(doting(t))
