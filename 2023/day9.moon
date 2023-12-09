iter = (nums) ->
  same = true
  n = nil
  new = {}
  for i = 1, #nums-1
    new[i] = nums[i+1] - nums[i]
    if not n
      n = new[i]
    if new[i] ~= n
      same = false
  --  io.write(new[i] .. " ")
  --print""

  if not same
    n = iter(new)
    return new[#new]+n
  else
    return n

sum=0
for line in io.open"day9.txt"\lines!
  nums = [tonumber n for n in line\gmatch"%-?%d+"]
  sum += nums[#nums] + iter(nums)

print sum
