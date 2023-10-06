ton=tonumber

local ROW=2000000

local m = {}

local rs={}

for sx, sy, bx, by in io.popen"xclip -se c -o":read"*a"
                     :gmatch(string.rep("[^\n%-%d]+(%-?%d+)",4)) do
  sx, sy, bx, by=ton(sx),ton(sy),ton(bx),ton(by)

  if by == ROW then
    m[bx]=0
  end

  local d = math.abs(bx-sx)+math.abs(by-sy)
  table.insert(rs, {sx=sx,sy=sy,d=d})

  local h = math.abs(ROW-sy)
  if h <= d then
    for i = sx-(d-h),sx+(d-h) do
      if not m[i] then
        cnt=(cnt or 0)+1
        m[i]=1
      end
    end
  end
end

print(cnt)

local function contains(x, y, sensor)
  return math.abs(sensor.sx-x) + math.abs(sensor.sy-y) <= sensor.d
end

local limit=4000000

for _, s in ipairs(rs) do
  for i =0,s.d do
    local x = -(s.d-i)-1+s.sx
    local y = i+s.sy
    if x < 0 or limit < x
    or y < 0 or limit < y
      then goto n1 end
    for _, s2 in ipairs(rs) do
      if contains(x, y, s2) then goto n1 end
    end
    print(x*4000000+y)
    ::n1::
  end
end
