local fish = {}
for i in io.read"l":gmatch"(%d+)" do
    fish[#fish + 1] = {tonumber(i), 1}
end

local function iter()
    local new = 0
    for i = 1, #fish do
        local f = fish[i][1]
        if f == 0 then
            fish[i][1] = 6
            new = new + fish[i][2]
        else
            fish[i][1] = f - 1
        end
    end
    if new > 0 then
        fish[#fish + 1] = {8, new}
    end
end

local function count()
    local cnt = 0
    for i = 1, #fish do
        cnt = cnt + fish[i][2]
    end
    return cnt
end

for i = 1, 80 do
    iter()
end

print("Part 1")
print(count())

for i = 81, 256 do
    iter()
end

print("Part 2")
print(count())
