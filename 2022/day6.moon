s=io.open"day6.txt"\read"*a"
find=(n)->
  for i=n,#s
    t={c,1 for c in *{s\byte(i-n+1,i)}}
    sum=0
    sum+=1 for _ in pairs t
    return i if sum == n
print find 4
print find 14
