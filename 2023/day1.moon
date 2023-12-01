a=0
for l in io.open"day1.txt"\lines!
  f = l\match"^.-(%d)"
  o = l\match"(%d)[^%d]*$"
  a+=tonumber (f..o)

print a

w = {"one":1,"two":2,"three":3,"four":4,"five":5,"six":6,"seven":7,"eight":8,"nine":9}

-- this is wrong
--a=0
--for l in io.open"day1.txt"\lines!
--  i=1
--  nl=""
--  while i <= #l
--    if tonumber l\sub(i,i)
--      nl..=l\sub(i,i)
--    else
--      for k, v in pairs w
--        if l\sub(i,i+#k-1) == k
--          nl..=v
--          i+=#k-1
--          break
--    i+=1
--  a+=nl\sub(1,1)..nl\sub(-1,-1)

a=0
for l in io.open"day1.txt"\lines!
  local x, y
  for i = 1, #l
    if tonumber l\sub(i,i)
      x=l\sub(i,i)
    else
      for k, v in pairs w
        if l\find(k, i, true) == i
          x = v
          break
    if x
      break
  for i = #l, 1, -1
    if tonumber l\sub(i,i)
      y=l\sub(i,i)
    else
      for k, v in pairs w
        if l\find(k, i, true) == i
          y = v
          break
    if y
      break
  a+=x..y

print a
