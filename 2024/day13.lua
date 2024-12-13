local function getopts(ax,ay,bx,by,cx,cy)
  local opts = {}
  bx=bx*3
  by=by*3
  cx=cx*3
  cy=cy*3
  local a = 0
  while a*ax<=cx and a*ay<=cy do
    local b = 0
    while true do
      local x = ax*a+bx*b
      local y = ay*a+by*b
      if x == cx and y == cy then
        table.insert(opts, a+b)
        break
      elseif x > cx or y > cy then
        break
      end
      b=b+1
    end
    a=a+1
  end
  table.sort(opts)
  return opts[1] or 0
end

local function gaussjordan(a, b)
  local x = {1,1}
  for k = 1, 200 do
    for i=1,2 do
      local sigma = 0
      for j = 1, 2 do
        if i ~= j then
          sigma = sigma + a[i][j] * x[j]
        end
      end
      x[i] = (b[i] - sigma) / a[i][i]
    end
  end
  if x[1] < 1e20 and x[2] < 1e20 and math.floor(x[1]) == x[1] and math.floor(x[2]) == x[2] then
    return x[1]+x[2]
  end
  return 0
end

local sum1 = 0
local sum = 0
for ax,ay,bx,by,cx,cy in io.read"*a":gmatch"Button A: X%+(%d+), Y%+(%d+)\nButton B: X%+(%d+), Y%+(%d+)\nPrize: X=(%d+), Y=(%d+)" do
  ax,ay,bx,by,cx,cy=tonumber(ax),tonumber(ay),tonumber(bx),tonumber(by),tonumber(cx),tonumber(cy)
  sum1 = sum1 + getopts(ax,ay,bx,by,cx,cy)
  cx=cx+10000000000000
  cy=cy+10000000000000
  local o1 = gaussjordan({{ax,bx*3},{ay,by*3}}, {cx*3,cy*3})
  local o2 = gaussjordan({{ay,by*3},{ax,bx*3}}, {cy*3,cx*3})
  sum = sum + o1 + o2
end

print(sum1)
print(math.floor(sum))
