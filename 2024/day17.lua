local a = io.read"*a"

local reg = {}
for r, v in a:gmatch"Register (.): (%d+)" do
  v = tonumber(v)
  reg[r]=v
end

local program = a:match"Program: (.*)$"

local ins={}
for c in program:gmatch"(%d)" do
  c=tonumber(c)
  table.insert(ins, c)
end

local ip=1

local function getcombo(c)
  if c <=3 then return c end
  if c==4 then return reg.A end
  if c==5 then return reg.B end
  if c==6 then return reg.C end
  return nil
  --assert(false)
end
local bit = require"bit"
local out = {}

while ip <= #ins do
  local nxt=ip+2
  local i=ins[ip]
  local l = ins[ip+1]
  local c = getcombo(l)
  if i == 0 then
    reg.A = math.floor(reg.A/2^c)
  elseif i == 1 then
    reg.B = bit.bxor(reg.B, l)
  elseif i == 2 then
    reg.B = c % 8
  elseif i == 3 then
    if reg.A ~= 0 then
      nxt = l+1
    end
  elseif i == 4 then
    reg.B = bit.bxor(reg.B, reg.C)
  elseif i == 5 then
    table.insert(out, c % 8)
  elseif i == 6 then
    reg.B = math.floor(reg.A/2^c)
  elseif i == 7 then
    reg.C = math.floor(reg.A/2^c)
  end
  ip=nxt
end

print(table.concat(out, ","))
