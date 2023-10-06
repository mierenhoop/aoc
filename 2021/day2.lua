local function part1()
    local x, d = 0, 0

    while true do
        local l = io.read"l"
        if not l then break end
        local s = l:find(" ", 1, true)
        local dir = l:sub(1, s -1)
        local n = tonumber(l:sub(s+1))

        if dir == "forward" then
            x = x + n
        elseif dir == "down" then
            d = d + n
        elseif dir == "up" then
            d = d - n
        end
    end

    print(x * d)
end

local function part2()
    local x, d, a = 0, 0, 0

    while true do
        local l = io.read"l"
        if not l then break end
        local s = l:find(" ", 1, true)
        local dir = l:sub(1, s -1)
        local n = tonumber(l:sub(s+1))

        if dir == "forward" then
            x = x + n
            d = d + (a * n)
        elseif dir == "down" then
            a = a + n
        elseif dir == "up" then
            a = a - n
        end
    end

    print(x * d)
end

part2()
