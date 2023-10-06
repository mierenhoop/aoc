local space = {}
local cycles = 6

local lines = {}
while true do
    local l = io.read "l"
    if not l then break end
    table.insert(lines, l)
end

local a = math.ceil(#lines / 2)
local b = math.ceil(#lines[1] / 2)

local cubes = {}
for i, v in ipairs(lines) do
    for j = 1, #v do
        if v:sub(j, j) == "#" then
            table.insert(cubes, {j - b, i - a, 0, 0})
        end
    end
end

local function cmpcube(a, b)
    for i = 1, #a do
        if a[i] ~= b[i] then
            return false
        end
    end
    return true
end

local function gen(x, y, z, w)
    local o = {}
    for i = -1, 1 do
        for j = -1, 1 do
            for k = -1, 1 do
                for l = -1, 1 do
                    if i ~= 0 or j ~= 0 or k ~= 0 or l ~= 0 then
                        o[#o + 1] = {x + i, y + j, z + k, w + l}
                    end
                end
            end
        end
    end
    return o
end

local function iter(arr)
    local na = {}

    for i = 1, #arr do
        local nbs = gen(arr[i][1], arr[i][2], arr[i][3], arr[i][4])
        local n = 0
        for j = 1, #nbs do
            local nnbs = gen(nbs[j][1], nbs[j][2], nbs[j][3], nbs[j][4])
            local nn = 0
            for k = 1, #arr do
                if cmpcube(nbs[j], arr[k]) then n = n + 1 end
                for l = 1, #nnbs do
                    if cmpcube(nnbs[l], arr[k]) then nn = nn + 1 end
                end
            end
            if nn == 3 then
                na[#na + 1] = nbs[j]
            end
        end
        if n == 2 or n == 3 then
            na[#na + 1] = arr[i]
        end
    end

    return na
end

local function trace(arr)
    local max = {0,0,0,0}
    for i = 1, 4 do
        for j = 1, #arr do
            local n = math.abs(arr[j][i])
            max[i] = n > max[i] and n or max[i]
        end
        print(max[i])
    end
    for i = -max[4], max[4] do
        for j = -max[3], max[3] do
            print("z="..j,"w="..i)
            for k = -max[2], max[2] do
                for l = -max[1], max[1] do
                    local v
                    for p = 1, #arr do
                        if cmpcube(arr[p], {l, k, j, i}) then
                            v = "#"
                            break
                        end
                    end
                    io.write(v or ".")
                end
                print""
            end
        end
    end
end

cubes = iter(cubes)
cubes = iter(cubes)
trace(cubes)

--trace(cubes)

-- local bh = #lines
-- local bw = #lines[1]
-- local ew = bw + (cycles) * 2
-- local eh = bh + (cycles+1) * 2
-- local ed = 1 + (cycles) * 2
-- local edm = (ed + 1) / 2
-- 
-- for i = 1, ed do
--     space[i] = {}
--     for j = 1, eh do
--         space[i][j] = {}
--         for k = 1, ew do
--             space[i][j][k] = 0
--         end
--     end
-- end
-- 
-- for i, l in ipairs(lines) do
--     local ip = math.floor(eh/2)-math.floor(bh/2)+i
--     for j = 1, #l do
--         local jp = math.floor(ew/2)-math.floor(bw/2)+j
--         space[edm][ip][jp] = (l:sub(j, j) == "#") and 1 or 0
--     end
-- end
-- 
-- local function deepcopy(t)
--     local nt = {}
--     for k, v in pairs(t) do
--         if type(v) == "table" then
--             nt[k] = deepcopy(v)
--         else
--             nt[k] = v
--         end
--     end
--     return nt
-- end
-- 
-- local function neighbours_active(s, x, y, z)
--     local n = 0
--     for i = z - 1, z + 1 do
--         for j = y - 1, y + 1 do
--             for k = x - 1, x + 1 do
--                 n = n + s[i][j][k]
--             end
--         end
--     end
--     return n - s[z][y][x]
-- end
-- 
-- local function iterate(s)
--     local ns = deepcopy(s)
--     for i = 2, ed - 1 do
--         for j = 2, eh - 1 do
--             for k = 2, ew - 1 do
--                 local n = neighbours_active(s, k, j, i)
--                 local act = s[i][j][k] == 1
--                 if act then
--                     if n ~= 2 and n ~= 3 then
--                         ns[i][j][k] = 0
--                     end
--                 else
--                     if n == 3 then
--                         ns[i][j][k] = 1
--                     end
--                 end
--             end
--         end
--     end
--     return ns
-- end
-- 
-- local function trace(s)
--     for i = 1, ed do
--         print("z="..(i-edm))
--         for j = 1, eh do
--             for k = 1, ew do
--                 io.write((s[i][j][k] == 1) and "#" or ".")
--             end
--             print""
--         end
--     end
-- end
-- 
-- for i = 1, cycles do
--     space = iterate(space)
-- end
-- 
-- --trace(space)
-- local sum = 0
-- for i = 1, ed do
--     for j = 1, eh do
--         for k = 1, ew do
--             sum = sum + space[i][j][k]
--         end
--     end
-- end
-- print(sum)




