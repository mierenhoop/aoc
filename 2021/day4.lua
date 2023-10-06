local numbersstr = io.read "l"
local numbers = {}
for i in numbersstr:gmatch"%d+" do
    table.insert(numbers, tonumber(i))
end
io.read"l"

local arr = {}
local map = {}

local card = {}
while true do
    local l = io.read"l"
    if not l then break end
    local r = {}
    if l == "" then
        arr[#arr + 1] = card
        card = {}
    else
        card[#card + 1] = r
    end
    for i in l:gmatch"%d+" do
        local i = tonumber(i)
        r[#r + 1] = i
        map[i] = map[i] or {pos = {}}
        map[i].pos[#map[i].pos + 1] = {#r, #card, #arr + 1}
    end
end
arr[#arr + 1] = card

print "bruh"

--for i, v in ipairs(arr) do
--    for j, b in ipairs(v) do
--        for k, n in ipairs(b) do
--            io.write(n.." ")
--        end
--        print""
--    end
--    print""
--end

local function contains(arr, v)
    for i = 1, #arr do
        if arr[i] == v then
            return true
        end
    end
    return false
end

local size = #arr[1]
local cardsize = size * size

local numcards = #arr

local winners = {}

for i = 1, #numbers do 
    local match = map[numbers[i]]
    if not match.marked then
        match.marked = true
        for j = 1, #match.pos do
            local pos, out = match.pos[j]
            for k = 1, size do
                if not map[arr[pos[3]][pos[2]][k]].marked then
                    break
                end
                out = k
            end
            if out ~= size then
                for k = 1, size do
                    if not map[arr[pos[3]][k][pos[1]]].marked then
                        break
                    end
                    out = k
                end
            end
            if out == size then
                local part
                if #winners == 0 then part = "Part 1" end
                if #winners == numcards - 1 and not contains(winners, pos[3]) then part = "Part 2" end
                if not contains(winners, pos[3]) then
                    table.insert(winners, pos[3])
                end
                if part then
                    local sum = 0
                    for k = 1, size do
                        for l = 1, size do
                            if not map[arr[pos[3]][k][l]].marked then
                                sum = sum + tonumber(arr[pos[3]][k][l])
                            end
                        end
                    end
                    print(part)
                    print(sum * numbers[i])
                    if part == "Part 2" then return end
                end
            end
        end
    end
end

