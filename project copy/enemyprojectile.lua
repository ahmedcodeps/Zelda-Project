local Object = require "libraries/classic"
local Projectile = Object:extend()

function Projectile:new(x,y,dir,image)
    self.image = love.graphics.newImage(image)
    self.x = x
    self.y = y
    self.speed = 150

    self.direction = dir

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.dead = false

end

function Projectile:update(dt,camX,camY)
    if self.direction.x == 1 then 
        self.x = self.x + self.speed * dt
    elseif self.direction.x == -1 then 
        self.x = self.x - self.speed * dt
    elseif self.direction.y == 1 then 
        self.y = self.y + self.speed * dt
    elseif self.direction.y == -1 then 
        self.y = self.y - self.speed * dt
    end

    if self.x > camX + 1024 or self.x < camX - 512 or self.y > camY + 480 or self.y < camY then
    self.dead = true
end


end

function Projectile:draw()
    love.graphics.draw(self.image,self.x,self.y)
end

function Projectile:checkCollision(obj)
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

return Projectile