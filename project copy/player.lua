---@diagnostic disable: lowercase-global, undefined-field

tick = require "libraries.tick"

local sword = require "sword"

local Player = Entity:extend()

local currentframe = 1

local attacking = false 
direction  = "up"
local attackTimer = 0

local canMove = true

local lastImage = nil

local anim1 = {
    love.graphics.newImage("images/linkup.png"),
    love.graphics.newImage("images/linkupanim.png"),
}

local anim2 = {
    love.graphics.newImage("images/linkdown.png"),
    love.graphics.newImage("images/linkdownanim.png"),
}

local anim3 = {
    love.graphics.newImage("images/linkright.png"),
    love.graphics.newImage("images/linkrightanim.png"),
}

local anim4 = {
    love.graphics.newImage("images/linkleft.png"),
    love.graphics.newImage("images/linkleftanim.png"),
}

local upanims = {}
for i=1,4 do 
    table.insert(upanims,love.graphics.newImage("images/sword/linkupattack"..i..".png"))
end

local downanims = {}
for i=1,4 do 
    table.insert(downanims,love.graphics.newImage("images/sword/linkdownattack"..i..".png"))
end

local rightanims = {}
for i=1,4 do 
    table.insert(rightanims,love.graphics.newImage("images/sword/linkrightattack"..i..".png"))
end

local leftanims = {}
for i=1,4 do 
    table.insert(leftanims,love.graphics.newImage("images/sword/linkleftattack"..i..".png"))
end


function Player:new(x,y)
    Player.super.new(self,x,y,"images/linkup.png")

    self.speed = 175
    self.health = 4
    self.strength = 0
    
    self.dead = false

    self.cooldown = 0
    
    self.damageTimer = 0
    
end

function Player:update(dt)
    tick.update(dt)

    if self.damageTimer > 0 then
        self.damageTimer = self.damageTimer - dt
    end

    if self.cooldown > 0 then 
        self.cooldown = self.cooldown - dt
    end

    if #listOfSwords >= 2 then 
        self.cooldown = 0.3
    end

    Player.super.update(self,dt)

    if canMove == true then
    if love.keyboard.isDown("up") then 
        self.y = self.y - self.speed * dt
        direction = "up"
    elseif love.keyboard.isDown("down") then 
        self.y = self.y + self.speed * dt
        direction = "down"
    elseif love.keyboard.isDown("right") then 
        self.x = self.x + self.speed * dt   
        direction = "right"
    elseif love.keyboard.isDown("left") then 
        self.x = self.x - self.speed * dt
        direction = "left"
    end
end

    currentframe = currentframe + 5 * dt
    if currentframe >= 2 then 
        tick.delay(function () currentframe = 1 end,0.1)
    end

    if attacking then 
         attackTimer = attackTimer + 10 * dt
    if attackTimer >= #upanims + 1 then 
        attacking = false 
        attackTimer = 1
        self.image = lastImage
        canMove = true
    end

    end

end

function Player:draw()
    -- set damage color
    if self.damageTimer > 0 then 
        if math.floor(self.damageTimer * 10) % 2 == 0 then 
            love.graphics.setColor(1, 0.3, 0.3, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
    end


    if attacking and direction == "up" then
        local frame = math.min(math.floor(attackTimer), #upanims)
        local img = upanims[frame]
        local offsetY = img:getHeight() - 32
        love.graphics.draw(img, self.x, self.y - offsetY)
    elseif attacking and direction == "down" then 
        local frame = math.min(math.floor(attackTimer), #downanims)
        love.graphics.draw(downanims[frame], self.x, self.y)
    elseif attacking and direction == "right" then
        local frame = math.min(math.floor(attackTimer), #rightanims)
        love.graphics.draw(rightanims[frame], self.x, self.y)
    elseif attacking and direction == "left" then
        local frame = math.min(math.floor(attackTimer), #leftanims)
        local img = leftanims[frame]
        local offsetX = img:getWidth() - 32
        love.graphics.draw(img, self.x - offsetX, self.y)
    elseif love.keyboard.isDown("up") then
        self.image = anim1[math.floor(currentframe)]
        Player.super.draw(self)
    elseif love.keyboard.isDown("down") then
        self.image = anim2[math.floor(currentframe)]
        Player.super.draw(self)
    elseif love.keyboard.isDown("right") then
        self.image = anim3[math.floor(currentframe)]
        Player.super.draw(self)
    elseif love.keyboard.isDown("left") then
        self.image = anim4[math.floor(currentframe)]
        Player.super.draw(self)
    else
        Player.super.draw(self)
    end

    -- reset color
    love.graphics.setColor(1, 1, 1, 1)
end


function Player:keypressed(key)
    lastKey = key
    if hasSword == true and key == "z" then 
        if self.cooldown <= 0 then
        lastImage = self.image
        attacking = true
        attackTimer = 1
        canMove = false
        if direction == "up" then 
            table.insert(listOfSwords, sword(player.x + 3, player.y,direction,"images/sword/swordup.png")) 
        elseif direction == "down" then 
            table.insert(listOfSwords, sword(player.x + 3, player.y,direction,"images/sword/swordown.png"))
        elseif direction == "right" then 
            table.insert(listOfSwords, sword(player.x, player.y,direction,"images/sword/swordright.png"))
        elseif direction == "left" then 
            table.insert(listOfSwords, sword(player.x, player.y,direction,"images/sword/swordleft.png"))
        end
    end
end
end


return Player