---@diagnostic disable: undefined-field

local Object = require "libraries/classic"
local Sword = Object:extend()

function Sword:new(x,y,dir,image)
    self.image = love.graphics.newImage(image)
    self.x = x
    self.y = y
    self.speed = 200

    self.direction = dir

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.dead = false

    self.flashTimer = 0

end

function Sword:update(dt,camX,camY)
    if self.direction == "right" then 
        self.x = self.x + self.speed * dt
    elseif self.direction == "left" then 
        self.x = self.x - self.speed * dt
    elseif self.direction == "down" then 
        self.y = self.y + self.speed * dt
    elseif self.direction == "up" then 
        self.y = self.y - self.speed * dt
    end

    if self.x > camX + 512 or self.x < camX or self.y > camY + 480 or self.y < camY then
        self.dead = true
    end

    self.flashTimer = self.flashTimer + dt

end

function Sword:draw()

   if math.floor(self.flashTimer * 20) % 2 == 0 then
        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setColor(1, 1, 0.3, 1) 
    end

    love.graphics.draw(self.image, self.x, self.y)
    love.graphics.setColor(1, 1, 1, 1)
end

function Sword:checkCollision(obj)
    local self_left = self.x
    local self_right = self.x + self.width
    local self_top = self.y
    local self_bottom  = self.y + self.height

    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bottom = obj.y + obj.height

    if self_right > obj_left and 
    self_left < obj_right and 
    self_bottom > obj_top and 
    self_top < obj_bottom then 
        self.dead = true

        obj.health = obj.health - 1

        obj.damageTimer = 0.5

        if obj.health <= 0 then 
            obj.dead = true
        end

    end
end

return Sword