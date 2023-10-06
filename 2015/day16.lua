Sue={}
for l in io.open("day16.txt", "r"):lines() do
  l = l:gsub(" (%d+):","[%1]={"):gsub(":","=").."}"
  load(l, nil, nil, _ENV)()
end

local props = {
  children= 3,
  cats= 7,
  samoyeds= 2,
  pomeranians= 3,
  akitas= 0,
  vizslas= 0,
  goldfish= 5,
  trees= 3,
  cars= 2,
  perfumes= 1
}

for i, s in ipairs(Sue) do
  for prop,v in pairs(props) do
    if s[prop] and s[prop] ~= v then
      goto nxt
    end
  end
  p1=i
  ::nxt::
  for prop,v in pairs(props) do
    if s[prop] then
      if (prop == "cats" or prop == "trees") then
        if s[prop] <= v then
          goto nxt2
        end
        goto skip
      elseif (prop == "pomeranians" or prop == "goldfish") then
        if s[prop] >= v then
          goto nxt2
        end
        goto skip
      elseif s[prop] ~= v then
        goto nxt2
      end
    end
    ::skip::
  end
  p2=i
  ::nxt2::
end

print(p1)
print(p2)
