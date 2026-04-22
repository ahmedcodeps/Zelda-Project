local Dragon = Enemy:extend()

local Dragonfire = require "dragonfire"



local anims = {
}

for i=1,4 do 
    table.insert(anims,love.graphics.newImage("images/enemy/dragon"..i..".png"))
end

local function randomDirection()
    local dirs = {{x=1,y=0},{x=-1,y=0}}
    local d = dirs[love.math.random(1,2)]
    return {x=d.x, y=d.y}  -- return a copy
end

function Dragon:new(x,y)
    Dragon.super.new(self,x,y,"images/enemy/dragon1.png")

    self.direction = randomDirection()

    self.health = 15

    self.currentframe = 1

    

     self.shootTimer = love.math.random(2,4)

end

function Dragon:update(dt,camX)
    self.last.x = self.x
    self.last.y = self.y

    if self.damageTimer > 0 then 
        self.damageTimer = self.damageTimer - dt
    end

   

    self.x = self.x + self.direction.x * self.speed * dt

    self.directionTimer = self.directionTimer - dt
    if self.directionTimer <= 0 then 
        self.direction = randomDirection()
        self.directionTimer = love.math.random(1,3)
    end

    self.currentframe = self.currentframe + 5 * dt
    if self.currentframe >= 5 then 
        self.currentframe = 1
    end

    self.shootTimer = self.shootTimer - dt
    if self.shootTimer <= 0 then 
        if self.health > 7 then 
            self.shootTimer = love.math.random(2,4)
            table.insert(projectiles, Dragonfire(self.x, self.y, {x=-1, y=0}, 1))
        elseif self.health >= 5 then 
            self.shootTimer = love.math.random(1,3)
            table.insert(projectiles, Dragonfire(self.x, self.y, {x=-1, y=0}, 2))
        elseif self.health >= 3 then 
            self.shootTimer = love.math.random(1,2)
            table.insert(projectiles, Dragonfire(self.x, self.y, {x=-1, y=0}, 3))
        else
            self.shootTimer = 1
            table.insert(projectiles, Dragonfire(self.x, self.y, {x=-1, y=0}, 4))
        end
    end
end


function Dragon:draw()
    self.image = anims[math.floor(self.currentframe)]
    Dragon.super.draw(self)


    
end

function Dragon:resolveCollision(block)

    if checkCollision(self, block) then
        local overlapright = (self.x + self.width) - block.x
        local overlapleft= (block.x + block.width) - self.x

        if overlapright < overlapleft then
            self.x = block.x - self.width
        else
            self.x = block.x + block.width
        end

        -- flip direction instead of random
        self.direction = randomDirection()
        self.directionTimer = love.math.random(1, 3)
    end
end

return Dragon