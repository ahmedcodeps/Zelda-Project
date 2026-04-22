
local Octorok = Enemy:extend()

local Projectile = require "enemyprojectile"

local anims1 = {
    love.graphics.newImage("images/enemy/octoright1.png"),
    love.graphics.newImage("images/enemy/octoright2.png")
}

local anims2 = {
    love.graphics.newImage("images/enemy/octoleft1.png"),
    love.graphics.newImage("images/enemy/octoleft2.png")
}

local anims3 = {
    love.graphics.newImage("images/enemy/octodown1.png"),
    love.graphics.newImage("images/enemy/octodown2.png")
}

local anims4 = {
    love.graphics.newImage("images/enemy/octoup1.png"),
    love.graphics.newImage("images/enemy/octoup2.png")
}

function Octorok:new(x,y)
    Octorok.super.new(self,x,y,"images/enemy/octoleft1.png")

    self.health = 2

    self.currentframe = 1
end

function Octorok:update(dt,camX)  -- if x is less than 1550 or greater than 2000
    Octorok.super.update(self,dt)

    self.currentframe = self.currentframe + 5 * dt
    if self.currentframe >= 3 then 
        self.currentframe = 1
    end

    if self.x < camX or self.x > camX + 512 then
        self.direction.x = -self.direction.x
    end

end

function Octorok:draw()
    Octorok.super.draw(self)

     if self.direction.x == 1 then 
        self.image = anims1[math.floor(self.currentframe)]
    elseif self.direction.x == -1 then 
        self.image = anims2[math.floor(self.currentframe)]
    elseif self.direction.y == 1 then 
        self.image = anims3[math.floor(self.currentframe)]
    elseif self.direction.y == -1 then 
        self.image = anims4[math.floor(self.currentframe)]
    end

    if self.shootTimer <= 0 then 
        self.shootTimer = love.math.random(2,4)
           table.insert(projectiles,Projectile(self.x,self.y,self.direction,"images/enemy/rock.png"))
    end

end

return Octorok