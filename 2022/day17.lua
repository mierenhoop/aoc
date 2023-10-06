local pieces = {
  {0011110},

  {0001000
  ,0011100
  ,0001000},

  {0000100
  ,0000100
  ,0011100},

  {0010000
  ,0010000
  ,0010000
  ,0010000},

  {0011000
  ,0011000},
}

local m ={}

function put()
  for r = #m+2,1,-1 do
    for c = 6,0,-1 do
      io.write(((((m[r] or 0) >> c) & 1) == 1) and "#" or ".")
    end
    print""
  end
end

for _, piece in ipairs(pieces) do
  for i, row in ipairs(piece) do
    piece[i]=tonumber(""..row,2)
  end
end

local function overlap(a,b)
  return (a&b) ~= 0
end

local function side(piece,dir)
  local ok=true
  for _, v in ipairs(piece) do
    if dir == ">" then
      if ((v & 1) ~= 0) then ok = false break end
    elseif dir == "<" then
      return v << ((v & 64) == 0) and 1 or 0
    end
  end
end

local pos = #m+3

--for iter = 1, 2023 do
--end
