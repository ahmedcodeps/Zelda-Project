local Object = require "libraries/classic"
local Dragonfire = Object:extend()

function Dragonfire:new(x,y,dir,stage)
    self.image = love.graphics.newImage("images/dragonattack/fire.png")
    self.image2 = love.graphics.newImage("images/dragonattack/blast1.png")
    self.image3 = love.graphics.newImage("images/dragonattack/blast2.png")
    self.image4 = love.graphics.newImage("images/dragonattack/blast3.png")

    self.x = x
    self.y = y
    self.speed = 150

    self.stage = stage

    self.direction = dir

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.dead = false

    self.offset = love.math.random(1,10)

end

function Dragonfire:update(dt,camX,camY)
        self.x = self.x + self.direction.x * self.speed * dt

        if self.stage == 1 then 
            self.speed = self.speed + 20
        elseif self.stage == 2 then 
            self.speed = self.speed + 30
        elseif self.stage == 3 then 
            self.speed = self.speed + 40
        elseif self.stage == 4 then 
            self.speed = self.speed + 50
        end
   

    if self.x > camX + 512 or self.x < camX or self.y > camY + 480 or self.y < camY then
        self.dead = true
    end


end

function Dragonfire:draw()

    if self.stage == 1 then 
    love.graphics.draw(self.image,self.x,self.y)
    elseif self.stage == 2 then 
        love.graphics.draw(self.image2,self.x,self.y)
        love.graphics.draw(self.image3,self.x,self.y)
    elseif self.stage == 3 then 
        love.graphics.draw(self.image2,self.x,self.y)
        love.graphics.draw(self.image3,self.x,self.y)
    elseif self.stage == 4 then 
        love.graphics.draw(self.image2,self.x,self.y)
        love.graphics.draw(self.image3,self.x,self.y)
        love.graphics.draw(self.image4,self.x,self.y)
    end
end

function Dragonfire:checkCollision(obj)
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

return Dragonfire