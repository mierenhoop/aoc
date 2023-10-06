local un=unpack
local map={}

local function id(x,y)
    return x..","..y
end

local start, nd
local y=1
for l in io.open"input.txt":lines() do
    map[y]={}
    local x=1
    for c in l:gmatch"." do
        if c == "S" then
            start={x,y}
            map[y][x]=string.byte"a"
        elseif c == "E" then
            nd={x,y}
            map[y][x]=string.byte"z"+1
        else
            map[y][x] = c:byte()
        end
        x=x+1
    end
    y=y+1
end
local w = #map[1]
local h = #map

function copy(t)
    local r={}
    for k,v in pairs(t) do r[k]=v end
    return r
end

local short={}

local min=math.huge
local function iter(l, v, x, y)
    --v is visited
    local dirs={{-1,0},{1,0},{0,-1},{0,1}}
    for _, dir in ipairs(dirs) do
        local nx, ny = x+dir[1],y+dir[2]
        -- if new positions are at end, and can access the end
        if id(nx,ny)==id(un(nd)) and map[y][x]==string.byte"z" then
            min=math.min(min,l)
            return
        end
        if  1 <= nx and nx <= w
        and 1 <= ny and ny <= h and not v[id(nx,ny)]
        and map[ny][nx] <= map[y][x]+1
        then
            if (short[id(nx,ny)] or math.huge) > l then
                short[id(nx,ny)]=l
                local nv = copy(v)
                nv[id(nx,ny)]=1
                iter(l+1, nv, nx, ny)
            end
        end
    end
end
--visited the start...
iter(1,{[id(un(start))]=1}, un(start))
print(min)
short={}
min=math.huge
local function iter(l, v, x, y)
    --v is visited
    local dirs={{-1,0},{1,0},{0,-1},{0,1}}
    for _, dir in ipairs(dirs) do
        local nx, ny = x+dir[1],y+dir[2]
        -- if new positions are at end, and can access the end
        if 1 <= nx and nx <= w
        and 1 <= ny and ny <= h and map[ny][nx]==string.byte"a" and map[y][x]==string.byte"b" then
            min=math.min(min,l)
            return
        end
        if  1 <= nx and nx <= w
        and 1 <= ny and ny <= h and not v[id(nx,ny)]
        and map[y][x] <= map[ny][nx]+1
        then
            if (short[id(nx,ny)] or math.huge) > l then
                short[id(nx,ny)]=l
                local nv = copy(v)
                nv[id(nx,ny)]=1
                iter(l+1, nv, nx, ny)
            end
        end
    end
end
--visited the start...
iter(1,{[id(un(nd))]=1}, un(nd))
print(min)
