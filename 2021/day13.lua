local pts = {}
while true do
    local l = io.read "l"
    if l == "" then break end
    
    for x, y in l:gmatch"(%d+),(%d+)" do
        table.insert(pts, {x = tonumber(x), y = tonumber(y)})
    end
end

local function count()
    local f = {}
    local c = 0

    for _, v in ipairs(pts) do
        local i = v.x .. "," .. v.y
        if not f[i] then f[i], c = 1, c + 1 end
    end
    print("Part 1", c)
end

local i = 0

while true do
    local l = io.read "l"
    if not l then break end

    for d, n in l:gmatch"fold along ([xy])=(%d+)" do
        i = i + 1
        n = tonumber(n)
        for _, p in ipairs(pts) do
            if p[d] > n then
                p[d] = math.floor(n - (p[d] - n))
            end
        end
        if i == 1 then
            count()
        end
    end
end

local mx, my = 0, 0
for i, v in ipairs(pts) do
    if v.x > mx then
        mx = v.x
    end
    if v.y > my then
        my = v.y
    end
end
local a = {}
for i, v in ipairs(pts) do
    a[v.y] = a[v.y] or {}
    a[v.y][v.x] = 1
end

for y = 0, my do
    for x = 0, mx do
        if a[y][x] then io.write"#" else io.write" " end
    end
    print""
end
