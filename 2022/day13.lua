local f = io.popen"xclip -se c -o"

function parse(s)
  return load("return "..s:gsub("%[","{"):gsub("%]","}"))()
end

function tos(v)
  if type(v) == "table" then 
    local s="["
    for i = 1, #v do
      s=s..tos(v[i])..","
    end
    return s.."]"
  else return tostring(v) end
end
function put(p1,p2,id)
  print(string.rep("  ", id).."Compare", tos(p1), tos(p2))
end

function compair(p1, p2,id)
  for i = 1, math.min(#p1,#p2) do
    if type(p1[i]) == "number" and type(p2[i]) == "number" then
      put(p1[i],p2[i],id)
      if p1[i] < p2[i] then return true end
      if p1[i] > p2[i] then return false end
    else
      put(p1[i],p2[i],id)
      if type(p1[i]) == "number" then p1[i]={p1[i]} end
      if type(p2[i]) == "number" then p2[i]={p2[i]} end
      put(p1[i],p2[i],id+1)
      local out= compair(p1[i], p2[i],id+2)
      if out == true then return true end
      if out == false then return false end
    end
  end
  if #p1 < #p2 then return true end
  if #p2 < #p1 then return false end
  return nil
end

local t = {"[[2]]","[[6]]"}
local cnt=0
local i = 1
repeat
  print(i)
  local p1, p2 = f:read"*l", f:read"*l"
  table.insert(t, p1)
  table.insert(t, p2)
  local out=compair(parse(p1), parse(p2),0)
  print("",out or false)
  if out then cnt=cnt+i end
  i=i+1
until not f:read"*l"

print(cnt)

table.sort(t, function(a,b) return compair(parse(a),parse(b),0) or false end)

local c=1
for i = 1, #t do
  if t[i] == "[[2]]" or t[i] == "[[6]]" then c=c*i end
end
print(c)
