local data = io.read "*a"

mem = {}

--local or_mask, and_mask
for k, v in data:gmatch "(%g+)%s=%s(%g+)" do
    g_v = v
    if k == "mask" then
        or_mask = tonumber(v:gsub("X", "0"),2)
        and_mask = tonumber(v:gsub("X", "1"),2)
    else
        load(k .. " = (g_v | or_mask) & and_mask")()
        --print((tonumber(v) | or_mask) & and_mask)
    end
end
local sum = 0
for k, v in pairs(mem) do
    sum = sum + v
end
print(sum)
