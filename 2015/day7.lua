local lines = {}

local refs = {}

for l in io.open("day7.txt","r"):lines() do
  local cmds, to = l:match"^(.*) %-> (%w+)"

  local refs = {}
  local s = ""

  for cmd in cmds:gmatch"%w+" do
    local b = ({AND="&",OR="|",LSHIFT="<<",RSHIFT=">>",NOT="0xffff&~"})[cmd] or cmd
    if b == cmd then
      refs[#refs+1] = b
      if not tonumber(b) then
      b = " e['"..b.."'] "
    end
    else
    end
    s=s..b
  end
  
  lines[to] = {refs=refs,cmd=s}
end

local done = {}
e={}

function doting(to)
  local refs, cmd = lines[to].refs, lines[to].cmd

  for i=1,2 do
    local ref = refs[i]
    if ref and not tonumber(ref) and not done[ref] then
      doting(ref)
      done[ref] = true
    end
  end
  local a,b = (loadstring or load)("e['"..to.."']".."="..cmd,nil,nil,_G)
  if not a then print(b) end
  a()
end

doting("a")

print(e.a)

lines["b"].cmd=e.a
lines["b"].refs = {}
done = {}
e={}
doting("a")
print(e.a)

--e={}
--for _, l in ipairs(lines) do
--  a = a:gsub("AND","&"):gsub("OR","|"):gsub("LSHIFT","<<"):gsub("RSHIFT",">>"):gsub("NOT","0xffff&~")
--
--  load(b.."="..a, nil, nil, e)()
--end
--
--print(e.a)
