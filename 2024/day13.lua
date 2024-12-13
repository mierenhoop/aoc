local function getopts(ax,ay,bx,by,cx,cy)
  local opts = {}
  local a = 0
  while a*ax<=cx and a*ay<=cy do
    local b = 0
    while true do
      local x = ax*a+bx*b
      local y = ay*a+by*b
      if x == cx and y == cy then
        table.insert(opts, a*3+b)
        break
      elseif x > cx or y > cy then
        break
      end
      b=b+1
    end
    a=a+1
  end
  --print(require"inspect"(opts))
  table.sort(opts)
  return opts[1] or 0
end

local sum = 0
for ax,ay,bx,by,cx,cy in io.read"*a":gmatch"Button A: X%+(%d+), Y%+(%d+)\nButton B: X%+(%d+), Y%+(%d+)\nPrize: X=(%d+), Y=(%d+)" do
  ax,ay,bx,by,cx,cy=tonumber(ax),tonumber(ay),tonumber(bx),tonumber(by),tonumber(cx),tonumber(cy)
  sum = sum + getopts(ax,ay,bx,by,cx,cy)
end

print(sum)
