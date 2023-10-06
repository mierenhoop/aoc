
local n=0
local n2 =0
for l in io.open("day5.txt","r"):lines() do
  local nice
  for i = 1, #l-1 do
    if l:byte(i) == l:byte(i+1) then nice = true end
  end

  nice = nice and l:match(("[aeoui].*"):rep(3))
  and not l:find"ab" and not l:find"cd" and not l:find"pq" and not l:find"xy"
  
  if nice then n  = n +1 end
  
  for i = 1, #l -1 do
    local s1 = l:sub(i,i+1)
    for j = i + 2, #l -1 do
      if s1 == l:sub(j,j+1) then
        for k = 1, #l - 2 do
          if l:byte(k) == l:byte(k+2) then
            n2 = n2 + 1
            break
          end
        end
        goto lop
      end
    end
  end
  ::lop::
end
print(n)
print(n2)