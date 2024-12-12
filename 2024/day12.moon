require"moon.all"
{insert:ins}=table

t={}
for l in io.lines!
  ins t, [c for c in l\gmatch"."]

w=#t[1]
h=#t


found={}
regions={}
search=(x,y,reg)->
  if found[x..","..y]
    return
  if not reg
    reg = {}
    ins regions, reg
  ins reg, {x,y}
  found[x..","..y] = true
  for {xx,yy} in *{{-1,0},{0,1},{0,-1},{1,0}}
    xx+=x
    yy+=y
    if 1<=xx and xx<=w and 1<=yy and yy<=h and t[y][x] == t[yy][xx]
      search(xx,yy, reg)
  
for y=1,h
  for x=1,w
    search x, y

p regions

sum=0
for reg in *regions
  reg.perim = 0
  reg.area=0
  for {x,y} in *reg
    reg.area+=1
    for {xx,yy} in *{{-1,0},{0,1},{0,-1},{1,0}}
      xx+=x
      yy+=y
      if not (1<=xx and xx<=w and 1<=yy and yy<=h) or t[y][x] != t[yy][xx]
        reg.perim+=1
  print reg.perim, reg.area
  sum +=reg.perim*reg.area

print sum

