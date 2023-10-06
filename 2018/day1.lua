print(load("return " .. io.open("day1.txt"):read("*a"))())

i=0

freqs={}

d={}

for l in io.open"day1.txt":lines() do
  d[#d+1]=tonumber(l)
end

n=1
while true do
  i=i+d[n]
  n=n+1
  if n > #d then n = 1 end
  if freqs[i] then print(i) break end
  freqs[i] = true
end

