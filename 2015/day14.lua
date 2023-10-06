sec=2503

max=0

tn=tonumber
deers={}
for l in io.open("day14.txt","r"):lines() do
  local name, sp, fly, rest = l:match"(%g+) can fly (%d+) km/s for (%d+) seconds, but then must rest for (%d+) seconds"
  sp,fly,rest=tn(sp),tn(fly),tn(rest)
  full=fly+rest
  d=math.floor(math.floor(sec/full) * (fly*sp))
  +math.min(sec%full,fly) * sp
  max=math.max(max,d)

  deers[name]={sp=sp,fly=fly,rest=rest,points=0,dis=0,state="fly",held=0}
end

print(max)

for i = 0, sec -1 do
  local bdrs = {}
  local bds = 0
  for deer, vs in pairs(deers) do
    vs.held = vs.held + 1
    if vs.state == "fly" then
      vs.dis = vs.dis + vs.sp
      if  vs.held >= vs.fly then
        vs.state = "rest"
        vs.held = 0
      end
    elseif vs.state == "rest" and vs.held >= vs.rest then
      vs.state = "fly"
      vs.held = 0
    end
    if vs.dis == bds then table.insert(bdrs,vs)
    elseif vs.dis > bds then bds = vs.dis bdrs = {vs} end
  end
  for _, dr in ipairs(bdrs) do
    dr.points = dr.points + 1
  end
end

best=0
for _, vs in pairs(deers) do
  best=math.max(best,vs.points)
end
print(best)
