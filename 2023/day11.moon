mult = 1
a = ->
  grid = {}
  wtsy = {}
  y=1
  for line in io.open"day11.txt"\lines!
    row = [c for c in line\gmatch"."]
    table.insert grid, row
    if line\match"^%.+$"
      wtsy[y]=mult
    y+=1
  
  wtsx = {}
  for ci = #grid[1], 1, -1
    dup = true
    for ri = 1, #grid
      if grid[ri][ci] ~= "."
        dup = false
    if dup
      wtsx[ci] = mult
  
  
  --for row in *grid
  --  for col in *row
  --    io.write(col)
  --  print""
  
  class IntPrioQueue
    new: =>
      @t = {}
  
    -- O(1) add
    put: (v, score) =>
      @t[score] or= {}
      table.insert @t[score], v
      if not @min or score < @min
        @min = score
      if not @max or score > @max
        @max = score
  
    empty: =>
      not @min
  
    -- O(?) get
    get: =>
      if not @min
        return
      ret = table.remove @t[@min]
      if #@t[@min] == 0
        for i = @min+1, @max
          if @t[i] and #@t[i] > 0
            @min = i
            break
        if #@t[@max] == 0
          @min, @max = nil, nil
      ret
  
  class SimplePrioQueue
    new: =>
      @t = {}
  
    put: (v, score) =>
      table.insert @t, {:v, :score}
      table.sort @t, (a, b) -> a.score > b.score
  
    empty: =>
      #@t == 0
  
    get: =>
      (table.remove @t).v
  
  gal = {}
  
  for y = 1, #grid
    for x = 1, #grid[y]
      if grid[y][x] == "#"
        --gal["#{x};#{y}"] = true
        table.insert gal, {x, y}
  
  
  LuaPrioQueue = load[==[
  --[[  Priority Queue implemented in lua, based on a binary heap.
  Copyright (C) 2017 Lucas de Morais Siqueira <lucas.morais.siqueira@gmail.com>
  License: zlib
    This software is provided 'as-is', without any express or implied
    warranty. In no event will the authors be held liable for any damages
    arising from the use of this software.
    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:
    1. The origin of this software must not be misrepresented; you must not
       claim that you wrote the original software. If you use this software
       in a product, an acknowledgement in the product documentation would be
       appreciated but is not required.
    2. Altered source versions must be plainly marked as such, and must not be
       misrepresented as being the original software.
    3. This notice may not be removed or altered from any source distribution.
  ]]--
  
  local floor = math.floor
  
  
  local PriorityQueue = {}
  PriorityQueue.__index = PriorityQueue
  
  setmetatable(
      PriorityQueue,
      {
          __call = function (self)
              setmetatable({}, self)
              self:initialize()
              return self
          end
      }
  )
  
  
  function PriorityQueue:initialize()
      --[[  Initialization.
      Example:
          PriorityQueue = require("priority_queue")
          pq = PriorityQueue()
      ]]--
      self.heap = {}
      self.current_size = 0
  end
  
  function PriorityQueue:empty()
      return self.current_size == 0
  end
  
  function PriorityQueue:size()
      return self.current_size
  end
  
  function PriorityQueue:swim()
      -- Swim up on the tree and fix the order heap property.
      local heap = self.heap
      local floor = floor
      local i = self.current_size
  
      while floor(i / 2) > 0 do
          local half = floor(i / 2)
          if heap[i][2] < heap[half][2] then
              heap[i], heap[half] = heap[half], heap[i]
          end
          i = half
      end
  end
  
  function PriorityQueue:put(v, p)
      --[[ Put an item on the queue.
      Args:
          v: the item to be stored
          p(number): the priority of the item
      ]]--
      --
  
      self.heap[self.current_size + 1] = {v, p}
      self.current_size = self.current_size + 1
      self:swim()
  end
  
  function PriorityQueue:sink()
      -- Sink down on the tree and fix the order heap property.
      local size = self.current_size
      local heap = self.heap
      local i = 1
  
      while (i * 2) <= size do
          local mc = self:min_child(i)
          if heap[i][2] > heap[mc][2] then
              heap[i], heap[mc] = heap[mc], heap[i]
          end
          i = mc
      end
  end
  
  function PriorityQueue:min_child(i)
      if (i * 2) + 1 > self.current_size then
          return i * 2
      else
          if self.heap[i * 2][2] < self.heap[i * 2 + 1][2] then
              return i * 2
          else
              return i * 2 + 1
          end
      end
  end
  
  function PriorityQueue:get()
      -- Remove and return the top priority item
      local heap = self.heap
      local retval = heap[1][1]
      heap[1] = heap[self.current_size]
      heap[self.current_size] = nil
      self.current_size = self.current_size - 1
      self:sink()
      return retval
  end
  
  return PriorityQueue]==]!
  
  nbs = (x, y) ->
    if not y
      x,y = x[1],x[2]
    [{xx, yy} for {xx, yy} in *{{x-1,y},{x+1,y},{x,y-1},{x,y+1}} when 1 <= xx and xx <= #grid[1] and 1 <= yy and yy <= #grid]
  
  ii = (x, y) ->
    if not y
      x,y = x[1],x[2]
    "#{x};#{y}"
  
  heuristic = (a, b) ->
    math.abs(a[1] - b[1]) + math.abs(a[2] - b[2])
  
  dist = (start, goal) ->
    frontier = LuaPrioQueue!
    frontier\put(start, 0)
  
    reached = {}
    came_from = {}
    cost_so_far = {}
    cost_so_far[ii start] = 0
  
  
    while not frontier\empty!
      current = frontier\get!
  	ic = ii current
      if ic == ii(goal)
        break
  
      for nxt in *nbs(current)
  	  inn = ii nxt
        new_cost = cost_so_far[ic] + (wtsx[nxt[1]] or 1) * (wtsy[nxt[2]] or 1)
        if not cost_so_far[inn] or new_cost < cost_so_far[inn]
          cost_so_far[inn] = new_cost
          prio = new_cost + heuristic(goal, nxt)
          frontier\put nxt, prio
          came_from[inn] = current
    cost_so_far[ii goal]
  
  
  dist = (start, goal) ->
    x1 = math.min(start[1], goal[1])
    x2 = math.max(start[1], goal[1])
    y1 = math.min(start[2], goal[2])
    y2 = math.max(start[2], goal[2])
  
    xd = 0
    yd = 0
    for y = y1+1, y2
      yd += wtsy[y] or 1
  
    for x = x1+1, x2
      xd += wtsx[x] or 1
    xd + yd
  
  sum=0
  for i = 1, #gal
    for j = i+1, #gal
      sum+=dist(gal[i], gal[j])
  
  print sum

a!
mult = 1000000
a!
