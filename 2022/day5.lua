local f = io.open"day5.txt"
local tn=tonumber

local stacks = {}
local rstcks = {}
for l in f:lines() do
  local n, from, to = l:match"move (%d+) from (%d+) to (%d+)"
  if not n then
    for i = 1, #l, 4 do
      local si = (i + 3) / 4
      if l:sub(i,i)=="[" then
        stacks[si] = stacks[si] or {}
        table.insert(stacks[si], l:sub(i+1,i+1))
      end
    end
  else
    if not sorted then 
      sorted = true
      for o, s in ipairs(stacks) do
        local ns, ns2 = {}, {}
        for i = 1, #s do
          ns[#s-i+1]=s[i]
          ns2[#s-i+1]=s[i]
        end
        stacks[o]=ns
        rstcks[o]=ns2
      end
    end
    n, from, to = tn(n), tn(from), tn(to)
    for i = 1, n do
      table.insert(stacks[to], table.remove(stacks[from]))
    end
    for i = 1, n do
      table.insert(rstcks[to], rstcks[from][#rstcks[from]-n+i])
    end
    for i = 1, n do table.remove(rstcks[from]) end
  end
end

for _, s in ipairs(stacks) do
  io.write(s[#s])
end
print""
for _, s in ipairs(rstcks) do
  io.write(s[#s])
end
print""
