---@diagnostic disable: lowercase-global

Block = Entity:extend()



function Block:new(x,y,image)
    Block.super.new(self,x,y,image)

    self.width = self.width - 8

    self.strength = 100

end

function Block:update(dt)
    Block.super.update(self,dt)
end


return Block