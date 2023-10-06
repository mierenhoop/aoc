local ls = {}
while true do
    local d = {}
    ls[#ls + 1] = d
    local l = io.read "l"
    if not l then break end
    for i = 1, #l do
        d[#d + 1] = {v = tonumber(l:sub(i, i))}
    end
end

local function add(t, v, x, y)
    if t[y] then
        v[#v + 1] = t[y][x]
    end
end

local vs = {}

for y = 1, #ls do
    for x = 1, #ls[y] do
        local v = ls[y][x]
        vs[#vs + 1] = v
        add(ls, v, x - 1, y - 1)
        add(ls, v, x, y - 1)
        add(ls, v, x + 1, y - 1)
        add(ls, v, x - 1, y)
        add(ls, v, x + 1, y)
        add(ls, v, x - 1, y + 1)
        add(ls, v, x, y + 1)
        add(ls, v, x + 1, y + 1)
    end
end

local flashes = 0


local function iter()
    for i = 1, #vs do
        vs[i].v = vs[i].v + 1
    end

    repeat
        local should = false
        for i = 1, #vs do
            if vs[i].v > 9 and not vs[i].flashed then
                should = true
                vs[i].flashed = true
                for j = 1, #vs[i] do
                    vs[i][j].v = vs[i][j].v + 1
                end
            end
        end
    until not should

    local fl = 0
    for i = 1, #vs do
        if vs[i].v > 9 then
            vs[i].flashed = false
            fl = fl + 1
            vs[i].v = 0
        end
    end
    flashes = flashes + fl
    if fl == #vs then
        return true
    end
end

local function trace()
    for y = 1, #ls do
        for x = 1, #ls[y] do
            io.write(ls[y][x].v)
        end
        print""
    end
end
local i = 1
while not iter() do
    if i == 100 then print("Part 1", flashes) end
    i = i + 1
end
print("Part 2", i)
