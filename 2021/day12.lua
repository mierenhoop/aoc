local conn = {}

for a, b in io.read"*a":gmatch"(%w+)%-(%w+)" do
    conn[a] = conn[a] or {}
    conn[b] = conn[b] or {}
    table.insert(conn[a], b)
    table.insert(conn[b], a)
end

local cnt = 0
local part = 1

local function dup(a)
    local b = {}
    for k, v in pairs(a) do
        b[k] = v
    end
    return b
end

local function getconns(k, no)
    local c = {}
    if k:upper() ~= k then
        no[k] = 1
    end
    if conn[k] then
        for i, v in ipairs(conn[k]) do
            if v == "end" then
                cnt = cnt + 1
            elseif not no[v] then
                c[v] = dup(no)
            elseif part == 2 and not no[0] and v ~= "start" then
                local d = dup(no)
                d[0] = 1
                c[v] = d
            end
        end
    end
    return c
end

local function iter(o, no)
    for v, i in pairs(getconns(o, no)) do
        iter(v, i)
    end
end

iter("start", {})
print("Part 1", cnt)
cnt, part = 0, 2
iter("start", {})
print("Part 2", cnt)
