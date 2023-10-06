local elves = {}
local cnt = 0
for l in io.open"day1.txt":lines() do
  if l == "" then 
    table.insert(elves,cnt)
    cnt = 0
  else
    cnt = cnt + tonumber(l)
  end
end
table.insert(elves,cnt)

--elves=(load or loadstring)("return{"..io.open"day1.txt":read"*a":gsub("(%d)\n(%d)", "%1+%2"):gsub("\n\n",",").."}")()

table.sort(elves, function(a,b) return a>b end)
print(elves[1])
print(elves[1]+elves[2]+elves[3])

