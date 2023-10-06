local input = io.popen "xclip -se c -o"



local n = 0
local c = 0

local function getstuff(cs)
  local s ={}
  for _, v in ipairs{20,60,100,140,180,220} do
    if c <v and v <= c + cs then
      s[#s+1]=v
    end
  end
  return ipairs(s)
end

local x = 1

local function pixel()
  local ax = c % 40

  if x-1 <= ax and ax <= x+1 then return "#"
  else return "." end
end

for l in input:lines() do
  local op, args = l:match"(%w+)%s*(%g*)"
  local cs,nx
  if op == "noop" then
    cs=1
  elseif op == "addx" then
    nx=tonumber(args)
    cs=2
  end

  for _, v in getstuff(cs) do
    n=n+v*x
  end

  for i = 1, cs do
    io.write(pixel())
    if c % 40 == 39 then print"" end
    c=c+1
  end
  x=x+(nx or 0)
end
print(n)
