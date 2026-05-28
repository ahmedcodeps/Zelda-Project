
local Tile = Entity:extend()


function Tile:new(x,y,image)
    Tile.super.new(self,x,y,image)
end

return Tile