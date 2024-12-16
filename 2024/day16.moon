require"moon.all"
m = for l in io.lines!
  [c for c in l\gmatch"."]
w,h=#m[1],#m
pos=nil
fin=nil
dirs={S:{0,1},W:{-1,0},N:{0,-1},E:{1,0}}
opp={S:"N",W:"E",N:"S",E:"W"}
for y=1,h
  for x=1,w
    if m[y][x] == "S"
      pos = {x,y,dir:dirs.E,prc:0}
    if m[y][x] == "E"
      fin={x,y}
tok=(p)->p[1]..","..p[2]
seen={}
q={pos}
while pos[1]!=fin[1] or pos[2]!=fin[2]
  seen[tok pos]=true
  for _, dir in pairs dirs
    if m[pos[2]+dir[2]][pos[1]+dir[1]] == "#"
      continue
    d=pos.dir
    turnprice = (d==dir and 0) or (opp[d]==dir and 2000 or 1000)
    o={pos[1]+dir[1],pos[2]+dir[2],dir:dir, prc:pos.prc+turnprice+1}
    if not seen[tok o]
      table.insert q, o
  table.sort q, (a,b) -> a.prc > b.prc
  pos = table.remove q
  --for y=1,h
  --  for x=1,w
  --    if x == pos[1] and y == pos[2]
  --      io.write("P")
  --    else
  --      io.write(m[y][x])
  --  print""

print pos.prc
