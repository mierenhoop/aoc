local s = {sum=0}
local t = {sum=0}

local function incr(v, x, y)
    v[y] = v[y] or {}
    local r = v[y][x] or 0
    v[y][x] = r + 1
    if r == 1 then
        v.sum = v.sum + 1
    end
end

local function run(l)
    for a, b, c, d in l:gmatch"(%d+),(%d+) %-> (%d+),(%d+)" do
        a, b, c, d = tonumber(a), tonumber(b), tonumber(c), tonumber(d)

        local is45 = math.floor(math.abs((d - b) / (c - a))) == 1

        local g, h = c > a and 1 or -1, d > b and 1 or -1

        if a == c or b == d then
            for y = b, d, h do
                for x = a, c, g do
                    incr(s, x, y)
                    incr(t, x, y)
                end
            end
        elseif is45 then
            local x, y = a, b
            while x ~= c and y ~= d do
                incr(s, x, y)
                x = x + g
                y = y + h
            end
            incr(s, x, y)
        end
    end
end

--while true do
--    local l = io.read "l"
--    if not l then break end
--    run(l)
--end
run(io.read"*a")

print("Part 1")
print(t.sum)

print("Part 2")
print(s.sum)
