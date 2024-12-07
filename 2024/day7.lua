local total = 0
local total2 = {}
for l in io.open"day7.txt":lines() do
  local ans, nums = l:match"(%d+): (.+)$"
  answer = tonumber(ans)
  local ops = {}
  for num in nums:gmatch"%d+" do
    table.insert(ops, tonumber(num))
  end
  local function try(sum, i)
    if sum > answer then return false end
    if i > #ops then
      return sum == answer
    end
    return try(sum*ops[i], i+1) or try(sum+ops[i], i+1)
  end
  if try(ops[1], 2) then
    total = total + answer
  end
  local function ilog10(n)
    --if n < 10 then return 1
    --elseif n < 100 then return 2
    --elseif n < 1000 then return 3
    --elseif n < 10000 then return 4
    --elseif n < 100000 then return 5
    --elseif n < 1000000 then return 6
    --elseif n < 10000000 then return 7
    --elseif n < 100000000 then return 8
    --elseif n < 1000000000 then return 9
    --elseif n < 10000000000 then return 10
    --else assert(false)
    --end
  end
  local function try2(sum, i)
    if sum > answer then return false end
    if i > #ops then
      return sum == answer
    end
    if try2(sum*ops[i], i+1) or try2(sum+ops[i], i+1) then
      return true
    else
      return try2(tonumber(sum..ops[i]), i+1)
    end
  end
  if try2(ops[1], 2) then
    table.insert(total2, ans)
  end
end
print(total)
local p = io.popen("bc", "w")
p:write(table.concat(total2, "+").."\n")
p:close()
