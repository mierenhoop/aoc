local tonumber = tonumber
local read = io.read

local lines, lines2 = {}, {}
while true do
    local l = read "l"
    if not l then break end
    lines[#lines+1] = l
    lines2[#lines2+1] = l
end

local s = #lines[1]

local function iter(arr, bit, m1, m2)
    local n1 = 0
    for i = 1 , #arr do
        if arr[i]:byte(bit) == string.byte("1") then
            n1 = n1 + 1
        end
    end

    local match = (n1 >= #arr / 2) and m1 or m2

    for i = #arr, 1, -1 do
        if arr[i]:sub(bit, bit) ~= match then
            table.remove(arr, i)
        end
    end
end

local function run(arr, m1, m2)
    for i = 1, s do
        iter(arr, i,m1, m2)
        if #arr == 1 then
            break
        end
    end
    return tonumber(arr[1], 2)
end

print(run(lines, "1", "0") * run(lines2, "0", "1"))
