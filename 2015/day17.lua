-- ruby
-- a=File.readlines("day17.txt").map{|x|x.to_i}
-- p2=nil
-- puts(a.length.times.map do |i| v = a.combination(i+1).map{|x|x.sum}.count(150)
--  if v > 0 and not p2 then p2 = v end
--  v
-- end.sum)
-- puts(p2)

local cons = {}

for n in io.open("day17.txt","r"):lines() do
  cons[#cons+1]=tonumber(n)
end


function comb(total, arr, thisiter, fromwhat, out, allout)
  thisiter = thisiter or 1
  fromwhat = fromwhat or 1
  out = out or {}
  allout = allout or {}
  if #out == total then
    allout[#allout+1] = out
    return allout
  end

  for i = fromwhat, #arr - (total - thisiter) do
    local newout = {}
    for j = 1, #out do
      newout[j] = out[j]
    end
    newout[#newout+1]=arr[i]
    comb(total, arr, thisiter+1, i+1, newout, allout)
  end
  return allout
end

local one = 0
for i = 1, #cons do
  for _,a in ipairs(comb(i, cons)) do
    local cnt = 0
    for _, b in ipairs(a) do
      cnt = cnt + b
    end
    if cnt == 150 then one = one + 1 end
  end
  if one > 0 and not two then two = one end
end
print(one)
print(two)
