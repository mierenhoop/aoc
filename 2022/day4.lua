local f=io.open"day4.txt":read"*a".."\n"
local tn=tonumber
local byte=string.byte

local n=0
local n2=0

local ns = {0,0,0,0}
local ni = 1
local ln = 0
for i = 1, #f do
  local b = byte(f,i)
  if byte"0" <= b and b <= byte"9" then
    ln = ln * 10
    ln = ln + b - byte"0"
  else
    ns[ni]=ln
    ln=0
    ni=ni+1
    if ni == 5 then
      local a, b, c, d = ns[1],ns[2],ns[3],ns[4]
      if (a <= c and d <= b)
      or (c <= a and b <= d) then
        n=n+1
      end
      if (a <= c and c <= b or a <= d and d <= b)
      or (c <= a and a <= d or c <= b and b <= d) then
        n2=n2+1
      end
      ni=1
    end
  end
end

---- original solution
--for a,b,c,d in f:gmatch"(%d+)%-(%d+),(%d+)%-(%d+)" do
--  a=tn(a) b=tn(b) c=tn(c) d=tn(d)
--  if (a <= c and d <= b)
--  or (c <= a and b <= d) then
--    n=n+1
--  end
--  if (a <= c and c <= b or a <= d and d <= b)
--  or (c <= a and a <= d or c <= b and b <= d) then
--    n2=n2+1
--  end
--end
print(n)
print(n2)
