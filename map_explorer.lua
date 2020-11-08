
function hex_tile(x, y, t)
   -- Interleave columns btwn layers; eats up two tile layers, but saves vram on
   -- the tile corners.
   local l = 1
   local x_off = 0
   local y_off = 1

   if x % 2 == 0 then
      l = 2
      x_off = 0
      y_off = 0
   end

   -- hex tiles start at index 1, 8 hardware tiles in size
   local cur = 1 + (t * 8)

   for j = y, y + 1 do
      for i = x, x + 3 do
         tile(l, x_off + i + x * 2, y_off + j + y, cur)
         cur = cur + 1
      end
   end
end

function which_tile(x, y)

end

cursor = { x=8, y=8 }

function cursor_pos()
   if cursor.x % 2 == 0 then
      return cursor.x * 8 * 3, cursor.y * 8 * 2
   else
      return cursor.x * 8 * 3, cursor.y * 8 * 2 + 8
   end
end

local cam = { x=0, y=0 }


function main_loop(update, draw)
   while update(delta()) do
      clear()
      draw()
      display()
   end
end

function update(dt)

   if btnp(5) then
      cursor.x = cursor.x + 1
   elseif btnp(4) then
      cursor.x = cursor.x - 1
   end

   if btnp(6) then
      cursor.y = cursor.y - 1
   elseif btnp(7) then
      cursor.y = cursor.y + 1
   end

   if btnp(3) then
      fade(1)
      next_script("test.lua")
      return false
   end

   local cx, cy = cursor_pos()
   cam.x = lerp(cam.x, cx + 15.9, dt * 0.000002)
   cam.y = lerp(cam.y, cy + 0.1, dt * 0.000002)

   return true
end

function lerp(v0, v1, t)
   return (1 - t) * v0 + t * v1;
end

function draw()
   local cx, cy = cursor_pos()
   spr(1, cx, cy)
   spr(2, cx + 16, cy)
   spr(3, cx, cy + 16)
   spr(4, cx + 16, cy + 16)

   camera(cam.x, cam.y)
end

print("ram: " .. tostring(collectgarbage("count") * 1024), 3, 5)

fade(0)

main_loop(update, draw)
