local Object = require "libraries/classic"

Enemy = Object:extend()

local Projectile = require "enemyprojectile"

local directions = {
    {x = 1, y = 0},
    {x = -1, y = 0},
    {x = 0, y = 1},
    {x = 0, y = -1},
}


function Enemy:new(x, y, image_path)
    self.x = x
    self.y = y

    self.image = love.graphics.newImage(image_path)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.speed = 60
    self.health = 1

    self.dead = false

    self.damageTimer = 0
    self.shootTimer = love.math.random(2,4)

    local d = directions[love.math.random(1, 4)]
    self.direction = {x = d.x, y = d.y} 
    self.directionTimer = love.math.random(1, 3)

    self.last = {x = x, y = y}

end

function Enemy:update(dt)
    self.last.x = self.x
    self.last.y = self.y

    if self.damageTimer > 0 then
        self.damageTimer = self.damageTimer - dt
    end

    self.shootTimer = self.shootTimer - dt

    self.x = self.x + self.direction.x * self.speed * dt
    self.y = self.y + self.direction.y * self.speed * dt

    self.directionTimer = self.directionTimer - dt
    if self.directionTimer <= 0 then
        local d = directions[love.math.random(1, 4)]
        self.direction = {x = d.x, y = d.y}
        self.directionTimer = love.math.random(1, 3)
    end

    
end

function Enemy:draw()

    if self.damageTimer > 0 then 
        love.graphics.setColor(1,1,1)

        if math.floor(self.damageTimer * 10) % 2 == 0 then 
            love.graphics.setColor(1,0.3,0.3,1)
        end
    end

    love.graphics.draw(self.image, self.x, self.y)
    love.graphics.setColor(1,1,1)
end

function Enemy:resolveCollision(block)
    if checkCollision(self, block) then
        local overlapLeft = (self.x + self.width) - block.x
        local overlapRight = (block.x + block.width) - self.x
        local overlapTop = (self.y + self.height) - block.y
        local overlapBottom = (block.y + block.height) - self.y

        local minOverlap = math.min(overlapLeft, overlapRight, overlapTop, overlapBottom)

        if minOverlap == overlapLeft then
            self.x = block.x - self.width
            local d = directions[love.math.random(1, 4)]
            self.direction = {x = d.x, y = d.y}
        elseif minOverlap == overlapRight then
            self.x = block.x + block.width
            local d = directions[love.math.random(1, 4)]
            self.direction = {x = d.x, y = d.y}
        elseif minOverlap == overlapTop then
            self.y = block.y - self.height
            local d = directions[love.math.random(1, 4)]
            self.direction = {x = d.x, y = d.y}
        elseif minOverlap == overlapBottom then
            self.y = block.y + block.height
            local d = directions[love.math.random(1, 4)]
            self.direction = {x = d.x, y = d.y}
        end
    end
end

return Enemy