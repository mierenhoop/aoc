require"moon.all"
m = for l in io.lines!
  [c for c in l\gmatch"."]
w,h=#m[1],#m
sta=nil
fin=nil
dirs={S:{0,1},W:{-1,0},N:{0,-1},E:{1,0}}
opp={S:"N",W:"E",N:"S",E:"W"}
for y=1,h
  for x=1,w
    if m[y][x] == "S"
      sta = {x,y,dir:dirs.E}
    if m[y][x] == "E"
      fin={x,y}
tok=(p)->p[1]..","..p[2]
seen={}
mp={}
pos=sta
dist={[tok pos]:0}
q={pos}
nodeturns={}
prev={}
orig={}
while #q > 0
  table.sort q, (a,b) -> dist[tok a] > dist[tok b]
  pos = table.remove q

  for _, dir in pairs dirs
    d=pos.dir
    if dir == opp[d]
      continue
    if m[pos[2]+dir[2]][pos[1]+dir[1]] == "#"
      continue
    turnprice = (d==dir and 0) or 1000
    prc = dist[tok pos]+1+turnprice
    o={pos[1]+dir[1],pos[2]+dir[2],dir:dir}
    if not dist[tok o] or prc <= dist[tok o]
      if not orig[tok pos]
        orig[tok pos] = dist[tok pos]
      dist[tok pos] = orig[tok pos]+turnprice
      dist[tok o] = prc
      prev[tok o] or={}
      table.insert(prev[tok o], pos)
      table.insert q, o

iter=(o)->
  if seen[tok o]
    return
  seen[tok o] = true
  cs = prev[tok o]
  if cs
    for c in *cs
      iter(c)
iter(fin)
sum=0
sum+=1 for s in pairs seen
print sum

--for y=1,h
--  for x=1,w
--    ok=false
--    io.write(seen[tok {x,y}] and "O" or m[y][x])
--  print""
