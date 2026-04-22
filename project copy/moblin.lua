
local Moblin = Enemy:extend()

local Projectile = require "enemyprojectile"

local anims1 = {
    love.graphics.newImage("images/enemy/moblinleft.png"),
    love.graphics.newImage("images/enemy/moblinleftattack.png")
}

local anims2 = {
    love.graphics.newImage("images/enemy/moblinright.png"),
    love.graphics.newImage("images/enemy/moblinrightattack.png")
}

local anims3 = {
    love.graphics.newImage("images/enemy/moblin.png"),
    love.graphics.newImage("images/enemy/moblinattack.png")
}

function Moblin:new(x,y)
    Moblin.super.new(self,x,y,"images/enemy/moblin.png")

    self.health = 4

    self.currentframe = 1
end

function Moblin:update(dt,camX)
    Moblin.super.update(self,dt)

    if self.x >= camX + 512 then 
        self.direction.x = -self.direction.x
    end

    self.currentframe = self.currentframe + 5 * dt
    if self.currentframe >= 3 then 
        self.currentframe = 1
    end

end

function Moblin:draw()
    Moblin.super.draw(self)

    if self.direction.x == 1 then 
        self.image = anims2[math.floor(self.currentframe)]
    elseif self.direction.x == -1 then 
        self.image = anims1[math.floor(self.currentframe)]
    elseif self.direction.y == 1 then 
        self.image = anims3[math.floor(self.currentframe)]
    elseif self.direction.y == -1 then 
        self.image = love.graphics.newImage("images/enemy/moblinup.png")
    end

    if self.shootTimer <= 0 then 
        self.shootTimer = love.math.random(2,4)
        if self.direction.x == 1 then 
           table.insert(projectiles,Projectile(self.x,self.y,self.direction,"images/enemy/arrowright.png"))
        elseif self.direction.x == -1 then 
            table.insert(projectiles,Projectile(self.x,self.y,self.direction,"images/enemy/arrowleft.png"))
        elseif self.direction.y == 1 then 
            table.insert(projectiles,Projectile(self.x,self.y,self.direction,"images/enemy/arrowdown.png"))
        elseif self.direction.y == -1 then 
            table.insert(projectiles,Projectile(self.x,self.y,self.direction,"images/enemy/arrowup.png"))
        end
    end

end

return Moblin