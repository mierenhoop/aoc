iter = (nums) ->
  same = true
  n = nil
  new = {}
  for i = 1, #nums-1
    new[i] = nums[i+1] - nums[i]
    n or= new[i]
    if new[i] ~= n
      same = false

  if not same
    p, n = iter(new)
    new[1] - p, new[#new]+n
  else
    n, n

sump, sumn = 0, 0
for line in io.open"day9.txt"\lines!
  nums = [tonumber n for n in line\gmatch"%-?%d+"]
  p, n = iter(nums)
  sump += nums[1] - p
  sumn += nums[#nums] + n

print sumn
print sump
