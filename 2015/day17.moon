a = [tonumber l for l in io.open"day17.txt"\lines!]

k=150
aa=0
e = (j, n) ->
  if n == k
    aa+=1
    return
  if n > k
    return
  for i = j, #a
    e i+1, n+a[i]

e 1, 0

print aa

mm=math.huge
o = (j, n, m) ->
  if n == k
    mm=math.min(mm,m)
    return
  if n > k
    return
  for i = j, #a
    o i+1, n+a[i], m+1

o 1, 0, 0

aa=0
u = (j, n, m) ->
  if n == k
    aa+=1
    return
  if n > k or m>=mm
    return
  for i = j, #a
    u i+1, n+a[i], m+1

u 1, 0, 0

print aa
