{insert:ins}=table
t={}
for l in io.lines!
  r={}
  ins t,r
  for c in l\gmatch"."
    ins r, tonumber c

w,h=#t[1],#t
m={}
for i =8,0,-1
  for y=1,h
    m[y]or={}
    for x=1,w
      m[y][x]or={}
      if t[y][x]==i
        for {xx,yy} in *{{-1,0},{0,-1},{1,0},{0,1}}
          xx+=x
          yy+=y
          if 1<=xx and xx<=w and 1<=yy and yy<=h and t[yy][xx] == i+1
            if i==8
              m[y][x][xx..","..yy] = true
            elseif m[y] and m[y][x]
              for k in pairs m[yy][xx]
                m[y][x][k] = true

sum=0
for y=1,h
  for x=1,w
    if t[y][x] == 0
      sum+=1 for k in pairs m[y][x]
print sum
