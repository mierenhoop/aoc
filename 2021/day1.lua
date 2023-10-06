--cjam part 1 & 2
--qN/:i2ew{~m0<}%1e=
--iqN/:i3ew{:+}%2ew{:m0<}%1e=

local part2 = true

local cache = {}
local prev
local cnt = 0
while true do
    local l = io.read "l"
    if not l then break end
    local n = tonumber(l)
    
    if part2 then
        cache[1] = cache[2]
        cache[2] = cache[3]
        cache[3] = n

        if cache[1] then
            n = cache[1] + cache[2] + cache[3]
        else
            n = nil
        end
    end

    if n and prev and n > prev then
        cnt = cnt + 1
    end
    prev = n
end

print(cnt)
