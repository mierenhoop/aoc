local input = io.open"day7.txt":read"*a".."\n$"

local fs = {}
local curpath = {}

local function add(k, v)
  local fsd=fs
  for _, folder in ipairs(curpath) do
    fsd=fsd[folder]
  end
  fsd[k] = v
end

for command, param, output in input:gmatch"%$ (%w+) ?([^\n]*)\n([^%$]*)" do
  if command == "cd" then
    if param == "/" then
      curpath={}
    elseif param == ".." then
      table.remove(curpath)
    else
      table.insert(curpath, param)
    end
  elseif command == "ls" then
    for size, name in output:gmatch"(%g+) (%g+)" do
      add(name, (size == "dir") and {} or tonumber(size))
    end
  end
end

local function count(folder)
  local sum = 0
  for k, v in pairs(folder) do
    if type(v) == "number" then
      sum = sum + v
    else
      sum = sum + count(v)
    end
  end
  folder.TOTALSUM=sum
  return sum
end

count(fs)

local freeup = fs.TOTALSUM-40000000
local tbd=math.huge

local total=0
function filter(folder)
  if folder.TOTALSUM >= freeup then
    tbd=math.min(tbd, folder.TOTALSUM)
  end

  if folder.TOTALSUM <= 100000 then
    total=total+folder.TOTALSUM
  end
  for k, v in pairs(folder) do
    if type(v) == "table" then
      filter(v)
    end
  end
end

filter(fs)

print(total)
print(tbd)
