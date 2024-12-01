require("moon.all")
local inp = io.open("day19.txt"):read("*a")
local a = inp:match("(%w+)%s*$")
local repl = inp
local oo = { }
for k, v in repl:gmatch("(%w+) => (%w+)") do
  oo[k] = oo[k] or { }
  table.insert(oo[k], v)
end
local all = { }
for i = 1, #a do
  local _continue_0 = false
  repeat
    local c = a:sub(i, i)
    if c:lower() == c then
      _continue_0 = true
      break
    end
    c = a:match("([A-Z][a-z]?)", i)
    if not oo[c] then
      _continue_0 = true
      break
    end
    local _list_0 = oo[c]
    for _index_0 = 1, #_list_0 do
      local rep = _list_0[_index_0]
      all[a:sub(1, i - 1) .. rep .. a:sub(i + #c)] = true
    end
    _continue_0 = true
  until true
  if not _continue_0 then
    break
  end
end
local s = 0
for _ in pairs(all) do
  s = s + 1
end
local uu = { }
for k, v in pairs(oo) do
  for _index_0 = 1, #v do
    local ii = v[_index_0]
    uu[ii] = uu[ii] or { }
    table.insert(uu[ii], k)
  end
end
local IntPrioQueue
do
  local _class_0
  local _base_0 = {
    put = function(self, v, score)
      self.t[score] = self.t[score] or { }
      table.insert(self.t[score], v)
      if not self.min or score < self.min then
        self.min = score
      end
      if not self.max or score > self.max then
        self.max = score
      end
    end,
    empty = function(self)
      return not self.max
    end,
    get = function(self)
      if not self.min or not self.max then
        return 
      end
      local ret = table.remove(self.t[self.min])
      if #self.t[self.min] == 0 then
        for i = self.min + 1, self.max do
          if self.t[i] and #self.t[i] > 0 then
            self.min = i
            break
          end
        end
        if #self.t[self.max] == 0 then
          self.min, self.max = nil, nil
        end
      end
      return ret
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.t = { }
    end,
    __base = _base_0,
    __name = "IntPrioQueue"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  IntPrioQueue = _class_0
end
local goal = "e "
local frontier = IntPrioQueue()
a = a .. " "
frontier:put(a, 0)
local came_from = { }
local cost_so_far = { }
cost_so_far[a] = 0
while not frontier:empty() do
  local current = frontier:get()
  if current == goal then
    break
  end
  for u, v in pairs(uu) do
    local _continue_0 = false
    repeat
      local b, e = current:find("(" .. u .. ")[^a-z]")
      if not b or not e then
        _continue_0 = true
        break
      end
      for _index_0 = 1, #v do
        local vv = v[_index_0]
        local n = current:sub(1, b - 1) .. vv .. current:sub(e)
        local new_cost = cost_so_far[current] + 1
        if not cost_so_far[n] or new_cost < cost_so_far[n] then
          cost_so_far[n] = new_cost
          local priority = new_cost + #n - 1
          frontier:put(n, priority)
          came_from[n] = current
        end
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
return print(cost_so_far["e "])
