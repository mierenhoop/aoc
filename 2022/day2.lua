f=io.open"day2.txt"
n=0
n2=0
rock={A=1,B=2,C=3,X=1,Y=2,Z=3}

for l in f:lines() do
  local a,b=l:match"(.) (.)"
  local ra, rb = rock[a], rock[b]
  local win = ((ra-1+1)%3)+1
  local lose = ((ra-1-1)%3)+1
  local equal = ra
  out={[win]=win+6,[lose]=lose+0,[equal]=equal+3}
  n=n+out[rb]
  out2={lose,equal,win}
  n2=n2+out[out2[rb]]

  --if ra == rb then
  --  n=n+rb+3
  --end
  --if ra == 1 then
  --  if rb == 2 then
  --    n=n+rb+6
  --    n2=n2+ra+3
  --  elseif rb == 3 then
  --    n=n+rb
  --    n2=n2+2+6
  --  else
  --    n2=n2+3
  --  end
  --elseif ra == 2 then
  --  if rb == 1 then
  --    n=n+rb
  --    n2=n2+1
  --  elseif rb == 3 then
  --    n=n+rb+6
  --    n2=n2+3+6
  --  else
  --    n2=n2+ra+3
  --  end
  --elseif ra == 3 then
  --  if rb == 1 then
  --    n=n+rb+6
  --    n2=n2+2
  --  elseif rb == 2 then
  --    n=n+rb
  --    n2=n2+ra+3
  --  else
  --    n2=n2+1+6
  --  end
  --end
end

print(n)
print(n2)
