local count = {}

local f = io.open("day19.txt","r")

while true do
  local l = f:read"*l"
  if l == "" then break end
  
  l=l:gsub("[a-z]",function(c)return c:byte() end):gsub("[A-Z]",function(c)return " "..c:byte() end)
  local f = tonumber(l:match"%d+")
  count[f]=count[f]or{}
  table.insert(count[f],load("return {"..l:match" =>  (.+)$":gsub(" ",",").."}")())
end

local total = 0
for k, v in pairs(count) do
  local cnt = 0
  for m in frm:gmatch(k.."[^a-z]?") do
    print(m)
    cnt = cnt + 1
  end
  total = total + cnt * v
end
print(total)

