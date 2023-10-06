
local fields = {}

local function add(a, b, k)
    for i = tonumber(a), tonumber(b) do
        fields[i] = fields[i] or {}
        fields[i][#fields[i] + 1] = k
    end
end

local all = {}

while true do
  local l = io.read "l"
  if l == "" then break end
  for k, ra, rb, rc, rd in l:gmatch "(.+): (%d+)-(%d+) or (%d+)-(%d+)" do
      add(ra, rb, k)
      add(rc, rd, k)
      table.insert(all, k)
  end
end

io.read"l"

local mine = {}
for v in io.read"l":gmatch"%d+" do
    mine[#mine + 1] = tonumber(v)
end

io.read"l"io.read"l"

local function makeset(a)
    local o = {}
    for i = 1, #a do
        o[a[i]] = 1
    end
    return o
end

local function dup(a)
    local b = {}
end

local function genarr(fn)
    local a = {}
    for b in fn do
        a[#a + 1] = b
    end
    return a
end

local function setand(a, b)
    for k in pairs(a) do
        if not b[k] then
            a[k] = nil
        end
    end
    return a
end

local function setor(a, b)
    for k, v in pairs(b) do
        a[k] = v
    end
    return a
end

local function settoarr(s)
    local a = {}
    for k in pairs(s) do
        a[#a + 1] = k
    end
    return a
end

local sets = {}
local inval = 0
while true do
  local l = io.read "l"
  if not l then break end

  local nums = {}
  for v in l:gmatch"%d+" do
      if nums then
          table.insert(nums, v)
      end
      if not fields[tonumber(v)] then
          nums = nil
          inval = inval + tonumber(v)
      end
  end
  if nums then
      for i, v in ipairs(nums) do
          sets[i] = sets[i] or makeset(all)
          setand(sets[i], makeset(fields[tonumber(v)]))
      end
  end
end
print "Part 1"
print(inval)

local function iter()
    for i = 1, #sets do
        local cnt = 0
        local last
        for j, l in pairs(sets[i]) do
            if j ~= 1 then
                cnt = cnt + 1
                last = j
            end
        end
        if cnt == 1 then
            sets[i][1] = last
            for k = 1, #sets do
                sets[k][last] = nil
            end
            break
        end
    end
end

for i = 1, #sets do
    iter()
end

--for i, v in ipairs(sets) do
--    for j, l in ipairs(v) do
--        io.write(l.." ")
--    end
--    print""
--end

local prod = 1
for i, v in ipairs(sets) do
    if v[1]:match"departure.*" then
        prod = prod * mine[i]
    end
end
print "Part 2"
print(prod)
