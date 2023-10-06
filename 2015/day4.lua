local digest=require"openssl.digest"

local data=io.open("day4.txt","r"):read"*a":match"%w+"

local i=0
local p1
while true do
  local f=digest.new"MD5":final(data..i)
  if f:sub(1,2)=="\0\0" and f:byte(3,3) < 16 then
      if not p1 then p1 = i end
      if f:byte(3,3) == 0 then
        break
      end
  end 
  i=i+1
end
print(p1)
print(i)