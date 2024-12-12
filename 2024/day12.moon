{insert:ins}=table

t={}
for l in io.open"day12.txt"\lines!
  ins t, [c for c in l\gmatch"."]

w=#t[1]
h=#t

dirs={{-1,0},{0,1},{0,-1},{1,0}}

found={}
regions={}
search=(x,y,reg)->
  if found[x..","..y]
    return
  if not reg
    reg = {}
    ins regions, reg
  o = {x,y, edges:{}}
  reg[x..","..y] = o
  found[x..","..y] = true
  for dir in *dirs
    {xx,yy}=dir
    xx+=x
    yy+=y
    if 1<=xx and xx<=w and 1<=yy and yy<=h and t[y][x] == t[yy][xx]
      search(xx,yy, reg)
    else
      o.edges[dir] = 0
  
for y=1,h
  for x=1,w
    search x, y

sum1=0
sum=0
for reg in *regions
  perim = 0
  area=0
  idt=0
  for k, v in pairs reg
    x,y=k\match"(%d+),(%d+)"
    x=tonumber x
    y=tonumber y
    area+=1
    for edge, id in pairs v.edges
      if id == 0
        idt+=1
        v.edges[edge]=idt
    perim += 1 for edge in pairs v.edges
    for edge, id in pairs v.edges
      for {xxx,yyy} in *dirs
        xx=x
        yy=y
        while true
          xx+=xxx
          yy+=yyy
          o = reg[xx..","..yy]
          break if not o or not o.edges[edge]
          if o.edges[edge]
            o.edges[edge] = id
  nids=0
  ids={}
  for k, v in pairs reg
    for edge, id in pairs v.edges
      ids[id]=1
  nids+=1 for id in pairs ids
  sum1+=perim*area
  sum +=nids*area

print sum1
print sum

