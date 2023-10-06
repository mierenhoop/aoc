input=io.open"day7.txt"\read"*a".."\n$"

fs={}
path={}

for cmd, out in input\gmatch "%$ ([^\n]+)\n([^%$]*)"
  switch cmd
    when "ls"
      for size, name in out\gmatch "(%w+) ([^\n]+)"
        dir=fs
        dir=dir[nextdir] for nextdir in *path
        dir[name] = tonumber(size) or {}
    when "cd /"  path={}
    when "cd .." table.remove path
    else         table.insert path, (cmd\match "cd ([^\n]+)")

count = (dir) ->
  sum=0
  sum += tonumber(entry) or count entry for _,entry in pairs dir
  dir._SIZE = sum
  sum

count fs

freeup = fs._SIZE-40000000
deldirsize = math.huge

total=0

filter = (dir) ->
  if dir._SIZE >= freeup
    deldirsize = math.min deldirsize, dir._SIZE
  if dir._SIZE <= 100000
    total+=dir._SIZE
  for _, nextdir in pairs dir
    filter nextdir if type(nextdir) == "table"

filter fs

print total
print deldirsize
