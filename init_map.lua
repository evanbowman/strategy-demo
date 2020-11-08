
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

fade(1)

for x = 0, 20 do
   for y = 0, 30 do
      hex_tile(x, y, 0)
   end
end

hex_tile(7, 7, 1)
hex_tile(7, 8, 1)
hex_tile(8, 8, 1)

next_script("map_explorer.lua")
