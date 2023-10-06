--monkeys={}
--
--local input=io.popen"xclip -se c -o":read"*a".."\n\n"
--
--input=input:gsub("Monkey (%d+):", "monkeys[%1]={")
--     :gsub("Starting items: ([^\n]+)", "starting={%1},")
--     :gsub("Operation: new = ([^\n]+)",
--           "operation=load('return function(old)return %1 end')(),")
--     :gsub("Test: divisible by (%d+)", "divisible=%1,")
--     :gsub("If (%w+): throw to monkey (%d+)", "[%1]=%2,")
--     :gsub("\n\n","}\n")
--
--load(input)()
--
----print(monkeys[0].operation(79))
--
--local inspected={}
--
--for r=1,20 do
--  for i=0,#monkeys do
--    local monkey=monkeys[i]
--    monkey.catch={}
--  end
--  for i=0,#monkeys do
--    local monkey=monkeys[i]
--    for _, starting in ipairs(monkey.starting) do
--      local new = math.floor(monkey.operation(starting) / 3)
--      local test = (new % monkey.divisible) == 0
--      local to = monkey[test]
--      table.insert(monkeys[to].catch, new)
--      inspected[i]=(inspected[i]or 0)+1
--    end
--    for _, catch in ipairs(monkey.catch) do
--      local new = math.floor(monkey.operation(catch) / 3)
--      local test = (new % monkey.divisible) == 0
--      local to = monkey[test]
--      table.insert(monkeys[to].catch, new)
--      inspected[i]=(inspected[i]or 0)+1
--    end
--    monkey.catch={}
--    monkey.starting=monkey.catch
--  end
--  print(r)
--  for i=0,#monkeys do
--    io.write(i..": ")
--    local monkey=monkeys[i]
--    for _, catch in ipairs(monkey.catch) do
--      io.write(catch..", ")
--    end
--    print""
--  end
--end
--
--for i=#monkeys,0,-1 do
--  inspected[i+1]=inspected[i]
--  inspected[i]=nil
--end
--
--table.sort(inspected)
--
--print(inspected[#inspected]*inspected[#inspected-1])

monkeys={}

local input=io.popen"xclip -se c -o":read"*a".."\n\n"

input=input:gsub("Monkey (%d+):", "monkeys[%1]={")
:gsub("Starting items: ([^\n]+)", "starting={%1},")
:gsub("Operation: new = ([^\n]+)",
"operation=load('return function(old)return %1 end')(),")
:gsub("Test: divisible by (%d+)", "divisible=%1,")
:gsub("If (%w+): throw to monkey (%d+)", "[%1]=%2,")
:gsub("\n\n","}\n")

load(input)()

local mod=1
for i = 0, #monkeys do
  mod=mod*monkeys[i].divisible
end

local inspected={}

for r=1,10000 do
  for i=0,#monkeys do
    local monkey=monkeys[i]
    monkey.catch={}
  end
  for i=0,#monkeys do
    local monkey=monkeys[i]
    for _, starting in ipairs(monkey.starting) do
      local new = math.floor(monkey.operation(starting))
      local test = (new % monkey.divisible) == 0
      local to = monkey[test]
      table.insert(monkeys[to].catch, new%mod)
      inspected[i]=(inspected[i]or 0)+1
    end
    for _, catch in ipairs(monkey.catch) do
      local new = math.floor(monkey.operation(catch))
      local test = (new % monkey.divisible) == 0
      local to = monkey[test]
      table.insert(monkeys[to].catch, new%mod)
      inspected[i]=(inspected[i]or 0)+1
    end
    monkey.catch={}
    monkey.starting=monkey.catch
  end
  print(r)
  for i=0,#monkeys do
    print(i, inspected[i])
  end
end

for i=#monkeys,0,-1 do
  inspected[i+1]=inspected[i]
  inspected[i]=nil
end

table.sort(inspected)

print(inspected[#inspected]*inspected[#inspected-1])
