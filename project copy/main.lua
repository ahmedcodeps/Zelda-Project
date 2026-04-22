---@diagnostic disable: undefined-global,lowercase-global

-- ~/Downloads/love.app/Contents/MacOS/love ~/Downloads/project

require "entity"
require "maps"
local Player = require "player"
local Blocks = require "blocks"
local Tile = require "tiles"
require "enemy"


local gameFinished = false


local Moblin = require "moblin"
local Leever = require "leever"
local Octorok = require "octorok"
local Dragon = require "dragon"

local stair
local tempmap1 = map1


local Width = 512
local Height = 480

local blacktile = love.graphics.newImage("images/blacktile.png")

local cameraX = 0
local cameraY = 0


area = 0
local lastarea = -1
local currentmap


-- booleans and debounces
local entered = false
 hasSword = false
local areaCooldown = 1
local swordcutscenelen = 0.3

local shakeDuration = 0

local heartimage = love.graphics.newImage("images/Hearts.png")
local HUD = love.graphics.newImage("images/HUD.png")

function displayHealth(health)
    love.graphics.draw(HUD,0,0)
    for i=1,health do 
        love.graphics.draw(heartimage,15 + i * 25,50)
    end
    love.graphics.print("Sprites By: Mister Mike",50,80)
end

function clearTable()
    

     for i=#blocks,1,-1 do 
            table.remove(blocks,i)
     end

     for i=#tiles,1,-1 do 
        table.remove(tiles,i)
     end

     for i=#enemies,1,-1 do 
        table.remove(enemies,i)
     end
end

function setArea(map,areacode)
    currentmap = map

    if map == tempmap1 then 
    for i,row in ipairs(map) do 
        for j,col in ipairs(row) do 
            if col == 1 then 
                table.insert(blocks,Blocks((j-1)*32 + (Width * areacode), (i-1)*32 + (Height * areacode),"images/treewall.png"))
            elseif col == 0 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32 + (Height * areacode), "images/tile.png"))
            end
        end
    end
end

if map == cave then 
    for i,row in ipairs(map) do 
        for j,col in ipairs(row) do 
            if col == 0 then 
                love.graphics.setColor(0,0,0)
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32 + (Height * areacode),"images/blacktile.png"))
                love.graphics.setColor(1,1,1)
            elseif col == 1 then 
                table.insert(blocks,Blocks((j-1)*32 + (Width * areacode),(i-1)*32 + (Height * areacode), "images/wall.png"))
            elseif col == 2 and hasSword == false then 
                sword.x = (j-1)*32
                sword.y = (i-1)*32
                sword.width = sword.image:getWidth()
                sword.height = sword.image:getHeight()
            end
        end
    end
end

if map == map2 then 
    for i,row in ipairs(map2) do 
        for j,col in ipairs(row) do 
            if col == 1 then 
                table.insert(blocks,Blocks((j-1)*32 + (Width * areacode), (i-1)*32,"images/treewall.png"))
            elseif col == 0 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/tile.png"))
            elseif col == 5 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/tile.png"))
                table.insert(enemies,Moblin((j-1)*32 + (Width * areacode),(i-1)*32))
            end
        end
    end
end

if map == map3 then 
    for i,row in ipairs(map3) do 
        for j,col in ipairs(row) do 
            if col == 1 then 
                table.insert(blocks,Blocks((j-1)*32 + (Width * areacode), (i-1)*32,"images/treewall.png"))
            elseif col == 0 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/tile.png"))
            elseif col == 5 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/tile.png"))
                table.insert(enemies,Leever((j-1)*32 + (Width * areacode),(i-1)*32))

            end
        end
    end
end

if map == map4 then 
    for i,row in ipairs(map4) do 
        for j,col in ipairs(row) do 
            if col == 1 then 
                table.insert(blocks,Blocks((j-1)*32 + (Width * areacode), (i-1)*32,"images/rocks.png"))
            elseif col == 0 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/tile.png"))
            elseif col == 2 then 
                table.insert(blocks,Blocks((j-1)*32 + (Width * areacode),(i-1)*32, "images/water.png"))
            elseif col == 5 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/tile.png"))
                table.insert(enemies,Octorok( (j-1)*32 + (Width * areacode) , (i-1)*32 ))
            end
        end
    end
end

if map == map5 then 
    for i,row in ipairs(map5) do 
        for j,col in ipairs(row) do 
            if col == 1 then 
                table.insert(blocks,Blocks((j-1)*32 + (Width * areacode), (i-1)*32,"images/treewall.png"))
            elseif col == 0 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/tile.png"))
            elseif col == 3 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32,"images/tile.png"))
                table.insert(enemies,Leever((j-1)*32 + (Width * areacode),(i-1)*32))
            elseif col == 4 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32,"images/tile.png"))
                table.insert(enemies,Moblin((j-1)*32 + (Width * areacode),(i-1)*32))
            elseif col == 5 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/tile.png"))
                table.insert(enemies,Octorok( (j-1)*32 + (Width * areacode) , (i-1)*32 ))
            end
        end
    end
end

if map == map5open then 
    for i,row in ipairs(map5open) do 
        for j,col in ipairs(row) do 
            if col == 1 then 
                table.insert(blocks,Blocks((j-1)*32 + (Width * areacode), (i-1)*32,"images/treewall.png"))
            elseif col == 0 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/tile.png"))
            end
        end
    end
end

    if map == map6 then 
        shakeDuration = 0.2
        player.health = 5
        for i,row in ipairs(map6) do 
        for j,col in ipairs(row) do 
            if col == 1 then 
                table.insert(blocks,Blocks((j-1)*32 + (Width * areacode), (i-1)*32,"images/bosstile2.png"))
            elseif col == 0 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/bosstile.png"))
            elseif col == 5 then 
                 table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/bosstile.png"))
                 table.insert(enemies,Dragon((j-1)*32 + (Width * areacode),(i-1)*32))
            end
        end
    end
end

if map == winmap then
    shakeDuration = 0.3
    for i,row in ipairs(winmap) do 
        for j,col in ipairs(row) do 
            if col == 1 then 
                table.insert(blocks,Blocks((j-1)*32 + (Width * areacode), (i-1)*32,"images/bosstile2.png"))
            elseif col == 0 then 
                table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/bosstile.png"))
            elseif col == 5 then 
                 table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/bosstile.png"))
                 table.insert(tiles,Tile((j-1)*32 + (Width * areacode),(i-1)*32, "images/Zelda.png"))
            end
        end
    end
end


end





function love.load()
    -- screen settings and maps
    stair = love.graphics.newImage("images/stairs.png")

    love.graphics.setBackgroundColor(0.39,0.39,0.39)
    love.window.setMode(512,480)

    player = Player(love.graphics.getWidth()/2,love.graphics.getHeight()/2)

    sword = {
        image = love.graphics.newImage("images/sword/sword.png"),
        x = 0,
        y = 0,
        width = 0,
        height = 0
    }

    blocks = {}
    tiles = {}
    enemies = {}

    listOfSwords = {}
    projectiles = {}

    stairs = {
        x = 0,
        y = 0,
        width = 0,
        height = 0
    }

end

function love.update(dt)
    player:update(dt)

    if shakeDuration > 0 then 
        shakeDuration = shakeDuration - dt
    end

    if player.dead == true then
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.health = 5
    player.dead = false
    area = 0
    cameraX = 0
    cameraY = 0
end

    for _,block in ipairs(blocks) do 
        block:update(dt)
        block:resolveCollision(player)
    end

    for _,tile in ipairs(tiles) do 
        tile:update(dt)
    end

    for i, enemy in ipairs(enemies) do
    enemy:update(dt,cameraX)

    for _, block in ipairs(blocks) do
        enemy:resolveCollision(block)
    end

    if checkCollision(player,enemy) and player.damageTimer <= 0 then 

        player.health = player.health - 1

        player.damageTimer = 0.4

        if player.health <= 0 then 
            player.dead = true
        end
    end

    if enemy.dead == true then 
        table.remove(enemies,i)
    end
end

   for i,v in ipairs(listOfSwords) do 
      v:update(dt,cameraX,cameraY)

    for j,enemy in ipairs(enemies) do 
       v:checkCollision(enemy)
    end

     if v.dead then 
        table.remove(listOfSwords,i)
    end

end

    for i,p in ipairs(projectiles) do 
        p:update(dt,cameraX,cameraY)

        p:checkCollision(player)

        if p.dead then 
            table.remove(projectiles,i)
        end

    end

   


    if area ~= lastarea then 
        clearTable()
    if area == 0 then 
    setArea(tempmap1,0)
    elseif area == 100 then 
    setArea(cave,0)
    elseif area == 1 then 
    setArea(map2,1)
    elseif area == 2 then 
    setArea(map3,2)
    elseif area == 3 then 
    setArea(map4,3)
    elseif area == 4 then 
    setArea(map5,4)
    elseif area == 5 then 
        setArea(map6,5)
    end
    lastarea = area
end


    if player.x > cameraX + Width then 
        cameraX = cameraX + Width
        area = area + 1
    elseif player.x < cameraX then
        cameraX = cameraX - Width
        area = area - 1
        end

    if player.y > cameraY + Height then 
        cameraY = cameraY + Height
        area = area + 1
    elseif player.y < cameraY then 
        cameraY = cameraY - Height
        area = area - 1
    end

    if area == 4 and #enemies == 0 and lastarea == 4 then 
        if currentmap ~= map5open then 
            clearTable()
            setArea(map5open,4)
        end
    end


    areaCooldown = areaCooldown - dt
    if hasSword == true then
        tempmap1 = openmap1
    swordcutscenelen = swordcutscenelen - dt
    end


    if area == 5 and lastarea == 5 and #enemies == 0 then 
        if currentmap ~= winmap then 
            clearTable()
            setArea(winmap,5)

            tick.delay(function () gameFinished = true end,2.5)
        end
    end

end

function love.draw()
    love.graphics.push()
    love.graphics.translate(-cameraX,-cameraY)

    if gameFinished == true then 
        love.graphics.setColor(0,0,0)
    end


    if shakeDuration > 0 then 
        love.graphics.translate(love.math.random(-2,1),love.math.random(-2,1))
    end

    for _,tile in ipairs(tiles) do
        tile:draw()
    end

    

    for _,block in ipairs(blocks) do
        block:draw()
    end

    for _,enemy in ipairs(enemies) do 
        enemy:draw()
    end

    for i,v in ipairs(listOfSwords) do 
        v:draw()
    end

    for _,p in ipairs(projectiles) do 
        p:draw()
    end

    -- stair drawing code
    if area == 0 or area == 100 then
     for i,row in ipairs(tempmap1) do 
        for j,col in ipairs(row) do 
            if col == 2 then 
                love.graphics.draw(stair,(j-1)*32 + cameraX,(i-1)*32 + cameraY)
                stairs.x = (j-1)*32 + cameraX
                stairs.y = (i-1)*32 + cameraY
                stairs.width = stair:getWidth()
                stairs.height = stair:getHeight()
            end
        end
    end
end

-- drawing sword and black tile
    if area == 100  then
        love.graphics.draw(blacktile,sword.x,sword.y)
        if hasSword == false then
        love.graphics.draw(sword.image,sword.x,sword.y)
        end
    end
    
    -- draw player
    player:draw()

    love.graphics.pop()



    if checkCollision(player,stairs) and areaCooldown <= 0 then 
        areaCooldown = 1
        if entered == false then
            entered = true
            area = 100
        else
            area = 0
            entered = false
        end
    end
    
    if area == 100 and hasSword == false then
    if checkCollision(player,sword) then 
        player.image = love.graphics.newImage("images/sword/pickup.png")
        hasSword = true
    end
elseif hasSword == true and swordcutscenelen > 0 then 
    love.graphics.draw((love.graphics.newImage("images/sword/sword.png")),player.x + 10,player.y - 20)
end

   displayHealth(player.health)
end

function love.keypressed(key)
    player:keypressed(key)

    if key == "right" then 
        player.image = love.graphics.newImage("images/linkright.png")
    elseif key == "left" then 
        player.image = love.graphics.newImage("images/linkleft.png")
    elseif key == "up" then 
        player.image = love.graphics.newImage("images/linkup.png")
    elseif key == "down" then 
        player.image = love.graphics.newImage("images/linkdown.png")
    end
end

function checkCollision(a,b)
    return a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height
end