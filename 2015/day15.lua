
local tings={{},{},{},{},{}}
local j=1
for l in io.open("day15.txt","r"):lines() do
  local i = 1
  for n in l:gmatch"%-?%d+" do
    tings[i][j] = tonumber(n)
    i=i+1
  end
  j=j+1
end

local maxc=0
local max = 0

for i = 1, 97 do
  for j = 1, 98-i do
    for k = 1, 99-i-j do
      local l = 100-i-j-k
      local cnt = 1
      for b=1,5 do
        local ting=tings[b]
        if b ~= 5 then
          cnt = cnt * math.max(ting[1]*i+ting[2]*j+ting[3]*k+ting[4]*l,0)
        else
          if ting[1]*i+ting[2]*j+ting[3]*k+ting[4]*l == 500 then
            maxc = math.max(cnt,maxc)
          end
        end
      end
      max = math.max(max,cnt)
    end
  end
end

print(max)
print(maxc)