local l = "1113222113"

local function iter(l)
  local out = {}
  local last = l:sub(1,1)
  local n = 0
  for i = 1, #l do
    local c = l:sub(i,i)
    if last ~= c then
      out[#out+1] = n
      out[#out+1] = last
      n = 1
      last = c
    else
      n = n + 1
    end
  end
  out[#out+1] = n
  out[#out+1] = last
  return table.concat(out)
end

for i = 1, 50 do
  l = iter(l)
  if i == 40 then print(#l) end
end
print(#l)

