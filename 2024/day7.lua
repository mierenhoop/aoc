local total = 0
for l in io.open"day7.txt":lines() do
  local answer, nums = l:match"(%d+): (.+)$"
  answer = tonumber(answer)
  local ops = {}
  for num in nums:gmatch"%d+" do
    table.insert(ops, tonumber(num))
  end
  local function try(sum, i)
    if sum > answer then return false end
    if i > #ops then
      if sum == answer then return true end
      return false
    end
    return try(sum*ops[i], i+1) or try(sum+ops[i], i+1)
  end
  if try(ops[1], 2) then
    total = total + answer
  end
end
print(total)
