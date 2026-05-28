
local Leever = Enemy:extend()



local anims = {
    love.graphics.newImage("images/enemy/leever1.png"),
    love.graphics.newImage("images/enemy/leever2.png")
}

local function randomDirection()
    local dirs = {{x=0,y=1},{x=0,y=-1}}
    local d = dirs[love.math.random(1,2)]
    return {x=d.x, y=d.y}  -- return a copy
end

function Leever:new(x,y)
    Leever.super.new(self,x,y,"images/enemy/leever1.png")

    self.direction = randomDirection()

    self.health = 4

    self.resolveCooldown = 0

    self.currentframe = 1
end

function Leever:update(dt,camX)
    self.last.x = self.x
    self.last.y = self.y

    if self.damageTimer > 0 then 
        self.damageTimer = self.damageTimer - dt
    end

    if self.resolveCooldown > 0 then
        self.resolveCooldown = self.resolveCooldown - dt
    end

    self.y = self.y + self.direction.y * self.speed * dt

    self.directionTimer = self.directionTimer - dt
    if self.directionTimer <= 0 then 
        self.direction = randomDirection()
        self.directionTimer = love.math.random(1,3)
    end

    self.currentframe = self.currentframe + 15 * dt
    if self.currentframe >= 3 then 
        self.currentframe = 1
    end

end

function Leever:draw()
    self.image = anims[math.floor(self.currentframe)]
     Leever.super.draw(self)
end

function Leever:resolveCollision(block)
    if self.resolveCooldown > 0 then return end 

    if checkCollision(self, block) then
        local overlapTop = (self.y + self.height) - block.y
        local overlapBottom = (block.y + block.height) - self.y

        if overlapTop < overlapBottom then
            self.y = block.y - self.height
        else
            self.y = block.y + block.height
        end

        -- flip direction instead of random
        self.direction.y = self.direction.y * -1
        self.directionTimer = love.math.random(1, 3)
        self.resolveCooldown = 0.2
    end
end

return Leever